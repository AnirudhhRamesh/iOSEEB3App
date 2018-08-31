//
//  HelpViewController.swift
//  EEB3App
//
//  Created by RAMESH anirudhh on 17/08/2017.
//  Copyright © 2017 RAMESH anirudhh. All rights reserved.
//

import UIKit
import MessageUI

class HelpViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {
    
    
    var fbURLWeb: NSURL = NSURL(string: "https://www.facebook.com/EEB3-App-154990461721033")!
    var fbURLID: NSURL = NSURL(string: "fb://profile/154990461721033")!
    var weburl: NSURL = NSURL(string: "https://itunes.apple.com/us/app/temple-run/id420009108?mt=8")!
    
    var sectionName : [String] = ["Introduction", "Send us feedback", "Join the community", "Support us"]
    var sectionObjects : [String] = ["Feeling lost? Can't find what you're looking for? We have a useful video that will guide you through the app.", "Your input is very valuable to us! Contact us, and write down your suggestions and feedback!", "Go follow us on Facebook to receive alerts and further information on all our future updates!", "We're working hard on making this app better for you! If you're satisfied, please rate this app on the App Store!"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "helpcell") as! HelpFeedbackTableViewCell
        
        cell.labelDescription.text = sectionObjects[indexPath.row]
        cell.labelTitle.text = sectionName[indexPath.row]
        
        return cell
        
        /*
         let cellproject = tableView.dequeueReusableCell(withIdentifier: "projectcell", for: indexPath) as! ProjectsTableViewCell
         
         //cell.myImageproject.image = UIImage(named: websites[indexPath.row] + ".png")
         
         cellproject.myLabelproject.text = projects[indexPath.row]
         cellproject.myLabelDescriptionproject.text = projectsDescript[indexPath.row]
         cellproject.myImageproject.image = UIImage(named: projects[indexPath.row] + ".png")
         return (cellproject)
         */
    }
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return sectionName.count
    }
    
    /*
     public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
     {
     //myIndexprojects = indexPath.row
     //performSegue(withIdentifier: "websitesSegue", sender: self)
     }
     */
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        if sectionObjects[indexPath.row] == "Feeling lost? Can't find what you're looking for? We have a useful video that will guide you through the app."
        {
            UIApplication.shared.openURL(NSURL(string:"https://www.youtube.com/watch?v=QH2-TGUlwu4")! as URL)
        }
        else if sectionObjects[indexPath.row] == "Your input is very valuable to us! Contact us, and write down your suggestions and feedback!"
        {
            sendEmail()
            print("This is detecting properly")
        }
        else if sectionObjects[indexPath.row] == "Go follow us on Facebook to receive alerts and further information on all our future updates!"
        {
            if(UIApplication.shared.canOpenURL(fbURLID as URL)){
                // FB installed
                UIApplication.shared.openURL(fbURLID as URL)
            } else {
                // FB is not installed, open in safari
                UIApplication.shared.openURL(fbURLWeb as URL)
            }
        }
        else if sectionObjects[indexPath.row] == "We're working hard on making this app better for you! If you're satisfied, please rate this app on the App Store!"
        {
            var url  = NSURL(string: "itms-apps://itunes.apple.com/us/app/temple-run/id420009108?mt=8")
            if UIApplication.shared.canOpenURL(url! as URL) {
                UIApplication.shared.openURL(url! as URL)
            } else {
                // FB is not installed, open in safari
                UIApplication.shared.openURL(weburl as URL)
            }
        }
        else {
            myIndex = 0
        }
    }
    
    
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["gameratramesh@gmail.com"])
            mail.setMessageBody("<p>Dear developer, I have some feedback for your app...</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            let alertsocial = UIAlertController(title: "Could not find an email account", message: "You are not signed in to any email accounts on this device", preferredStyle: .alert)
            let actionsocial = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            
            alertsocial.addAction(actionsocial)
            present(alertsocial, animated: true, completion: nil)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}
