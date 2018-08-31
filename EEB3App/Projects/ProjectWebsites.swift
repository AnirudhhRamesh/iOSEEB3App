//
//  AutoTableViewController.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 27/03/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import UIKit
import FirebaseDatabase


class ProjectWebsites: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    
    //List of project string arrays where online data will be stored for text
    var ProjectTitles1:[String] = []
    var ProjectTexts1:[String] = []
    var ProjectButtons1:[String] = []
    var ProjectEmails1:[String] = []
    var ProjectLinks1:[String] = []
    var ProjectBanners1:String = ""
    var ProjectTypes1:[String] = []
    
    //The string array which will determine which page the content will be in
    
    //String so that they may share the project
    var ProjectShare: String = ""
    
    var imageCache = [String:UIImage]()
    
    var handle: DatabaseHandle?
    var ref: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.title = mySelectedProject
        print(mySelectedProject + "pineapple")
        ref = Database.database().reference()
        handle = ref?.child("project").child(mySelectedProject).child("Websites").observe(.childAdded, with: { (snapshot) in
            if let item = snapshot.value as? String
            {
                let itemKey = snapshot.key
                print(itemKey)
                if itemKey.range(of: "banner") != nil
                {
                    self.ProjectBanners1 = item
                }
                else if itemKey.range(of: "title") != nil
                {
                    self.ProjectTitles1.append(item)
                    if itemKey.range(of: "label") != nil            //To check whether it is a label
                    {
                        self.ProjectTypes1.append("label")
                    }
                    else if itemKey.range(of: "button") != nil      //To check whether it is a button
                    {
                        self.ProjectTypes1.append("button")
                    }
                    print("\(item)" + "pineapple title")
                }
                else if itemKey.range(of: "text") != nil
                {
                    self.ProjectTexts1.append(item)
                    print("\(item)" + "pineapple")
                }
                else if itemKey.range(of: "interact") != nil
                {
                    self.ProjectButtons1.append(item)
                    
                    print(item + "monkey")
                }
                else if itemKey.range(of: "link") != nil
                {
                    self.ProjectLinks1.append(item)
                }
                else if itemKey.range(of: "@") != nil
                {
                    self.ProjectEmails1.append(item)
                }
            }
            self.myTableView.reloadData()
        })
        
        //UpdateProjectsArray()
        self.myTableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if indexPath.row == 0 {
            var cell = tableView.dequeueReusableCell(withIdentifier: "AutoTableBannerCell") as! AutoTableBannerCell
            //set the data here
            
            if let url = ProjectBanners1 as? String,
                let imgURL = URL(string: url){
                
                cell.AutoTableBannerImage?.image = UIImage(named: "blankImage")
                if let img = imageCache[url] {
                    cell.AutoTableBannerImage?.image = img
                }
                else {
                    // The image isn't cached, download the img data
                    // We should perform this in a background thread
                    let session = URLSession.shared
                    let task = session.dataTask(with: imgURL) { (data, response, err) in
                        if err != nil {
                            return
                        }
                        let image = UIImage(data: data!)
                        // Store the image in to our cache
                        self.imageCache[url] = image
                        
                        DispatchQueue.main.async{
                            cell.AutoTableBannerImage?.image = image
                        }
                        //cell.myImageproject?.image = UIImage(data: data!)
                    }
                    task.resume()
                }
            }
            return cell
            
        }
        else if ProjectTypes1[indexPath.row - 1] == "label" {
            var cell = tableView.dequeueReusableCell(withIdentifier: "AutoTableTextCell") as! AutoTableTextCell
            //set the data here
            cell.AutoTableTextTitle.text = ProjectTitles1[indexPath.row - 1]
            cell.AutoTableTextTitle.textColor = hexStringToUIColor(hex: mySelectedProjectColour)
            
            cell.AutoTableTextContent.text = ProjectTexts1[indexPath.row - 1]
            
            return cell
        }
        else if ProjectTypes1[indexPath.row - 1] == "button" {
            var cell = tableView.dequeueReusableCell(withIdentifier: "AutoTableButtonCell") as! AutoTableButtonCell
            
            
            cell.AutoTableButton.setTitle(ProjectButtons1[indexPath.row - 1], for: .normal)
            cell.AutoTableButton.backgroundColor = hexStringToUIColor(hex: mySelectedProjectColour)

            cell.AutoTableButtonTitle.text = ProjectTitles1[indexPath.row - 1]
            cell.AutoTableButtonTitle.textColor = hexStringToUIColor(hex: mySelectedProjectColour)
            cell.AutoTableButtonContent.text = ProjectTexts1[indexPath.row - 1]
            
            //set the data here
            return cell
        }
        else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "AutoTableButtonCell") as! AutoTableButtonCell
            return cell
        }
    }
    
    @IBAction func ButtonClicked(_ sender: AnyObject) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.myTableView)
        let indexPath = (self.myTableView.indexPathForRow(at: buttonPosition)?.row)! - 1
        if indexPath != nil {
            print(indexPath)
            print("Rhino appears to be working!")
            
            print(ProjectLinks1[indexPath])
            
            if ProjectLinks1[indexPath].range(of: "instagram") != nil
            {
                var instagramHooks = ProjectLinks1[indexPath]
                var instagramUrl = NSURL(string: instagramHooks)
                if UIApplication.shared.canOpenURL(instagramUrl! as URL) {
                    UIApplication.shared.openURL(instagramUrl! as URL)
                } else {
                    //redirect to safari because the user doesn't have Instagram
                    var name: String = ProjectLinks1[indexPath]
                    let endIndex = name.index(name.startIndex, offsetBy: +26)
                    let truncated = name.substring(from: endIndex)
                    print(name)      // "Dolphin"
                    print(truncated) // "Dolph"
                    let safariLink = "https://www.instagram.com/" + truncated

                    UIApplication.shared.openURL(URL(string: safariLink)!)
                }
                
            }
            else if ProjectLinks1[indexPath].range(of: "fb") != nil
            {
                var instagramHooks = ProjectLinks1[indexPath]
                var instagramUrl = NSURL(string: instagramHooks)
                if UIApplication.shared.canOpenURL(instagramUrl! as URL) {
                    UIApplication.shared.openURL(instagramUrl! as URL)
                } else {
                    //redirect to safari because the user doesn't have Facebook
                    var name: String = ProjectLinks1[indexPath]
                    let endIndex = name.index(name.startIndex, offsetBy: +13)           //fb://profile/eeb3studentcourses
                    let truncated = name.substring(from: endIndex)
                    print(name)      // "Dolphin"
                    print(truncated) // "Dolph"
                    let safariLink = "https://www.facebook.com/" + truncated
                    
                    UIApplication.shared.openURL(URL(string: safariLink)!)
                }
            }
            else if ProjectLinks1[indexPath].range(of: "twitter") != nil
            {
                var instagramHooks = ProjectLinks1[indexPath]
                var instagramUrl = NSURL(string: instagramHooks)
                if UIApplication.shared.canOpenURL(instagramUrl! as URL) {
                    UIApplication.shared.openURL(instagramUrl! as URL)
                } else {
                    //redirect to safari because the user doesn't have Twitter
                    var name: String = ProjectLinks1[indexPath]
                    let endIndex = name.index(name.startIndex, offsetBy: +27)           // twitter://user?screen_name=\(screenName)
                    let truncated = name.substring(from: endIndex)
                    print(name)      // "Dolphin"
                    print(truncated) // "Dolph"
                    let safariLink = "https://www.twitter.com/" + truncated
                    
                    UIApplication.shared.openURL(URL(string: safariLink)!)
                }
                
            }
            else if ProjectLinks1[indexPath].range(of: "youtube") != nil
            {
                var instagramHooks = ProjectLinks1[indexPath]
                var instagramUrl = NSURL(string: instagramHooks)
                if UIApplication.shared.canOpenURL(instagramUrl! as URL) {
                    UIApplication.shared.openURL(instagramUrl! as URL)
                } else {
                    //redirect to safari because the user doesn't have Twitter
                    var name: String = ProjectLinks1[indexPath]
                    let endIndex = name.index(name.startIndex, offsetBy: +10)           // youtube://\(screenName)
                    let truncated = name.substring(from: endIndex)
                    print(name)      // "Dolphin"
                    print(truncated) // "Dolph"
                    let safariLink = "https://www.youtube.com/" + truncated
                    
                    UIApplication.shared.openURL(URL(string: safariLink)!)
                }
                
            }
            else if ProjectLinks1[indexPath].range(of: "@") != nil
            {
                var email: String = ProjectLinks1[indexPath]
            
                if let url = URL(string: "mailto:\(email)") {
                    UIApplication.shared.open(url)
                    print(url)
                }
                else{
                    print("error opening email")
                }
            }
            else {
                UIApplication.shared.open(URL(string : ProjectLinks1[indexPath])!, options: [:], completionHandler: { (status) in})
            }
        }
    }
    
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        print("\(ProjectTitles1.count)" + "pineapple")
        return ProjectTitles1.count + 1
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1//objectsArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "" //objectsArray[section].sectionName
    }
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
    }
    
}
