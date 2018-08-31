//
//  LoginScreenViewController.swift
//  EEB3App
//
//  Created by RAMESH anirudhh on 31/10/2017.
//  Copyright © 2017 RAMESH anirudhh. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CreateNotificationViewController: UIViewController {
    
    var handle: DatabaseHandle?
    var ref: DatabaseReference?
    
    var userEmail:String = ""
    var dateText:String = ""
    
    var NotificationValue: Int = 0
    
    @IBOutlet weak var notificationTitle: UITextField!
    @IBOutlet weak var notificationDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DateandTime()
        
        if let x = UserDefaults.standard.object(forKey: "myEmail") as? String{
            userEmail = x
        }
        print("Authentication successful")
        
        ref = Database.database().reference()
        handle = ref?.child("NotificationValue").observe(.childAdded, with: { (snapshot) in
            if let item = snapshot.value as? Int{
                self.NotificationValue = item
                print(item)
                print("Above value is the value of the notifValue")
            }
        })
    }
    
    func DateandTime() {
        
        let date = DateFormatter()
        
        date.dateStyle = .short
        date.locale = Locale(identifier: "fr_FR")
        date.setLocalizedDateFormatFromTemplate("dd-MM-yy")
        dateText = date.string(from: Date())
    }
    
    @IBAction func sendNotification(_ sender: Any) {
        
        let title = notificationTitle.text
        let description = notificationDescription.text
        
        if (title == ""){
            print("You haven't entered a title!")
            let alertsocial = UIAlertController(title: "Empty Title", message: "You haven't entered a title!", preferredStyle: .alert)
            let actionsocial = UIAlertAction(title: "Enter Title", style: .cancel, handler: nil)
            
            alertsocial.addAction(actionsocial)
            self.present(alertsocial, animated: true, completion: nil)
        }
        else if (description == ""){
            print("You haven't entered a description!")
            let alertsocial = UIAlertController(title: "Empty Description", message: "You haven't entered a description!", preferredStyle: .alert)
            let actionsocial = UIAlertAction(title: "Enter Description", style: .cancel, handler: nil)
            
            alertsocial.addAction(actionsocial)
            self.present(alertsocial, animated: true, completion: nil)
        }
        else if (title == "") && (description == ""){
            print("You haven't filled in your title or description")
            let alertsocial = UIAlertController(title: "Invalid Title and Description", message: "You haven't entered a title or a description!", preferredStyle: .alert)
            let actionsocial = UIAlertAction(title: "Enter Title and Description", style: .cancel, handler: nil)
            
            alertsocial.addAction(actionsocial)
            self.present(alertsocial, animated: true, completion: nil)
        }
            
        else if (title != "") && (description != ""){
            print("Title and description has been entered")
            if (title?.count)! < 34{
        ref?.child("Notifications").child(String(NotificationValue - 1)).setValue(
            [
                "notif1title": title,
                "notif1text": description,
                "notif1date": dateText,
                "notif1sender": userEmail
            ])
            
                ref?.child("NotificationValue").child("notifValue").setValue(NotificationValue - 1)

                
                let actionSheet = UIAlertController(title: "Notification successfully posted", message: "You have successfully created a new notification", preferredStyle: .alert)
                let actionSocial = UIAlertAction(title: "Dismiss", style: .default, handler: { (action:UIAlertAction) in
                    self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                })
                actionSheet.addAction(actionSocial)
                self.present(actionSheet, animated: true, completion: nil)
        }
            else {
                let alertsocial = UIAlertController(title: "Title is too long", message: "Your title is too long, please use less than 34 characters (including spaces).", preferredStyle: .alert)
                let actionsocial = UIAlertAction(title: "Re-enter Title", style: .cancel, handler: nil)
                alertsocial.addAction(actionsocial)
                self.present(alertsocial, animated: true, completion: nil)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
