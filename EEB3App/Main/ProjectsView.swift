//
//  SecondViewController.swift
//  EEB3App
//
//  Created by RAMESH anirudhh on 06/08/17.
//  Copyright © 2017 RAMESH anirudhh. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SystemConfiguration

var myIndexprojects = 0
var mySelectedProject = ""
var mySelectedProjectColour = ""

//List of project string arrays where online data will be stored
var Newsletters:[String] = []
var NewslettersDescriptions:[String] = []
var NewslettersImages:[String] = []
var NewslettersColours:[String] = []

var Events: [String] = []
var EventsDescriptions:[String] = []
var EventsImages: [String] = []
var EventsColours: [String] = []

var Miscellaneous: [String] = []
var MiscellaneousDescriptions:[String] = []
var MiscellaneousImages: [String] = []
var MiscellaneousColours: [String] = []

var Competitions: [String] = []
var CompetitionsDescriptions:[String] = []
var CompetitionsImages: [String] = []
var CompetitionsColours: [String] = []

var SchoolMerchandise: [String] = []
var SchoolMerchandiseDescriptions:[String] = []
var SchoolMerchandiseImages: [String] = []
var SchoolMerchandiseColours: [String] = []

var TableViewTitles: [String] = ["Newsletters", "Events", "Miscellaneous", "Competitions", "School Merchandise"]

var TableViewDescriptions: [String] = ["Newsletters Descriptions", "Events Descriptions", "Miscellaneous Descriptions", "Competitions Descriptions", "School Merchandise Descriptions"]

class ProjectsView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var myTableView: UITableView!

    //List of project images downloaded from online
    
    var imageCache = [String:UIImage]()

    var handle: DatabaseHandle?
    var ref: DatabaseReference?
    
    struct Objects {
        var sectionName : String!
        var sectionObjects : [String]!
        var sectionDescriptions : [String]!
        var sectionImages : [String]!
        var sectionNameColour : [String]!
    }
    
    var objectsArray = [Objects]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isInternetAvailable(){
        ref = Database.database().reference()
            handle = ref?.child("project").observe(.childAdded, with: { (snap) in
                for child in (snap.children) {
                    let snapshot = child as! DataSnapshot
                    let stringSnap = snap.key as? String
                    print("Dinosaur \(stringSnap)")
                if let item = snapshot.value as? String
                {
                    let itemKey = snapshot.key
                    print(itemKey)
                    if itemKey.range(of: "description") != nil
                    {
                        if stringSnap == "Newsletters"{
                            NewslettersDescriptions.append(item)
                        }
                        else if stringSnap == "Events"{
                            EventsDescriptions.append(item)
                        }
                        else if stringSnap == "Miscellaneous"{
                            MiscellaneousDescriptions.append(item)
                        }
                        else if stringSnap == "Competitions"{
                            CompetitionsDescriptions.append(item)
                        }
                        else if stringSnap == "School Merchandise"{
                            SchoolMerchandiseDescriptions.append(item)
                        }
                    }
                    else if itemKey.range(of: "image") != nil
                    {
                        if stringSnap == "Newsletters"{
                            NewslettersImages.append(item)
                        }
                        else if stringSnap == "Events"{
                            EventsImages.append(item)
                        }
                        else if stringSnap == "Miscellaneous"{
                            MiscellaneousImages.append(item)
                        }
                        else if stringSnap == "Competitions"{
                            CompetitionsImages.append(item)
                        }
                        else if stringSnap == "School Merchandise"{
                            SchoolMerchandiseImages.append(item)
                        }
                    }
                    else if itemKey.range(of: "colour") != nil
                    {
                        if stringSnap == "Newsletters"{
                            NewslettersColours.append(item)
                        }
                        else if stringSnap == "Events"{
                            EventsColours.append(item)
                        }
                        else if stringSnap == "Miscellaneous"{
                            MiscellaneousColours.append(item)
                        }
                        else if stringSnap == "Competitions"{
                            CompetitionsColours.append(item)
                        }
                        else if stringSnap == "School Merchandise"{
                            SchoolMerchandiseColours.append(item)
                        }
                    }
                    else {
                        if stringSnap == "Newsletters"{
                            Newsletters.append(item)
                        }
                        else if stringSnap == "Events"{
                            Events.append(item)
                        }
                        else if stringSnap == "Miscellaneous"{
                            Miscellaneous.append(item)
                        }
                        else if stringSnap == "Competitions"{
                            Competitions.append(item)
                            print(item)
                        }
                        else if stringSnap == "School Merchandise"{
                            SchoolMerchandise.append(item)
                        }
                    }
                }
                    self.UpdateProjectsArray()
                    self.myTableView.reloadData()
                }
                self.UpdateProjectsArray()
                self.myTableView.reloadData()
            })
            self.UpdateProjectsArray()
            self.myTableView.reloadData()
        }
        else{
            let alertsocial = UIAlertController(title: "No internet connection", message: "You aren't connected to the internet", preferredStyle: .alert)
            let actionsocial = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            
            alertsocial.addAction(actionsocial)
            self.present(alertsocial, animated: true, completion: nil)
        }
        //UpdateProjectsArray()
        //self.myTableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "projectcell") as! ProjectsTableViewCell
        
        if let colour = objectsArray[indexPath.section].sectionNameColour[indexPath.row] as? String,
        let title = objectsArray[indexPath.section].sectionObjects[indexPath.row] as? String,
        let description = objectsArray[indexPath.section].sectionDescriptions[indexPath.row] as? String,
        let url = objectsArray[indexPath.section].sectionImages[indexPath.row] as? String,
        let imgURL = URL(string: url){
            
            cell.myLabelproject.textColor = hexStringToUIColor(hex: colour)
            cell.myLabelproject.text = title
            cell.myLabelDescriptionproject.text = description
            
            cell.myImageproject?.image = UIImage(named: "EEB3App")
            if let img = imageCache[url] {
                cell.myImageproject?.image = img
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
                        cell.myImageproject?.image = image
                    }
                    //cell.myImageproject?.image = UIImage(data: data!)
                }
                task.resume()
            }
            }
        else{
            
            cell.myLabelproject.textColor = hexStringToUIColor(hex: "#3f51b5")
            cell.myLabelproject.text = "Error loading data"
            cell.myLabelDescriptionproject.text = "Error loading project description"
            cell.myImageproject?.image = UIImage(named: "EEB3App")
            
        }
        
        
        return cell
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
        return objectsArray[section].sectionObjects.count
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int
    {
        return objectsArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objectsArray[section].sectionName
    }
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        /*
        if objectsArray[indexPath.section].sectionObjects[indexPath.row] == "Student Courses"
        {
            performSegue(withIdentifier: "StudentCoursesSegue", sender: self)
        }
        else if objectsArray[indexPath.section].sectionObjects[indexPath.row] == "Short Film Festival"
        {
            performSegue(withIdentifier: "SFFSegue", sender: self)
        }
        else if objectsArray[indexPath.section].sectionObjects[indexPath.row] == "EEB.GREEN"
        {
            performSegue(withIdentifier: "EEBGREENSegue", sender: self)
        }
        */
        myIndexprojects = indexPath.row
        print("Giraffe" + "\(myIndexprojects)")
        
        mySelectedProject = objectsArray[indexPath.section].sectionObjects[indexPath.row]
        mySelectedProjectColour = objectsArray[indexPath.section].sectionNameColour[indexPath.row]
        print("Giraffe" + mySelectedProject)

        performSegue(withIdentifier: "AutoProjectSegue", sender: self)

        //if objectsArray[indexPath.section].sectionObjects[indexPath.row] == ref?.child("projects").child(TableViewTitles[indexPath.row]).description()
        
        
        //When a cell is clicked, get the value of sectionObjects, then iterate through all the strings that is named as sectionObject[i]. This is how you can get the corresponding page to open.
    }
    
    public func UpdateProjectsArray(){
        self.objectsArray = [Objects(sectionName: "Newsletters", sectionObjects: Newsletters, sectionDescriptions: NewslettersDescriptions, sectionImages: NewslettersImages, sectionNameColour: NewslettersColours),
                             Objects(sectionName: "Events", sectionObjects: Events, sectionDescriptions: EventsDescriptions, sectionImages: EventsImages, sectionNameColour: EventsColours),
                             Objects(sectionName: "Miscellaneous", sectionObjects: Miscellaneous, sectionDescriptions: MiscellaneousDescriptions, sectionImages: MiscellaneousImages, sectionNameColour: MiscellaneousColours),
                             Objects(sectionName: "Competitions", sectionObjects: Competitions, sectionDescriptions: CompetitionsDescriptions, sectionImages: CompetitionsImages, sectionNameColour: CompetitionsColours),
                             Objects(sectionName: "School Merchandise", sectionObjects: SchoolMerchandise, sectionDescriptions: SchoolMerchandiseDescriptions, sectionImages: SchoolMerchandiseImages, sectionNameColour: SchoolMerchandiseColours)]
    }
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
}
