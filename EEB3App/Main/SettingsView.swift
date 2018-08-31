//
//  FifthViewController.swift
//  EEB3App
//
//  Created by RAMESH anirudhh on 09/08/17.
//  Copyright © 2017 RAMESH anirudhh. All rights reserved.
//

import UIKit

class SettingsView: UITableViewController {

    var weburl: NSURL = NSURL(string: "https://itunes.apple.com/us/app/temple-run/id420009108?mt=8")!
    
    var x: Int = 0
    var myEasterEgg: [String] = ["This task button is currently not functioning", "I wasn't joking, this switch actually doesn't work!", "But seriously, stop it", "I'm not even kidding, my code is going to run out", "I wasn't made so that people could spam-click me", "Ok, fine, maybe I was...", "Because my developer thought this app needed an Easter egg", "Which is ironic, because I was made on Easter itself", "The reason he did it though, was because there's an exact same switch in the Android app.", "Yes, the Android EEB3 App, super successful, like this", "Thanks, anyway, I think that's about the end of my code", "Are you seriously still pressing me?", "You are truly dedicated, maybe you deserve an award", "There you go, you can be a 'Dedicated EEB3 App User'.", "This isn't the Oscars btw, you don't need to make a long unnecessary speech.", "Now that you're a dedicated user, why not rate this app 5 stars?"]
    var myEasterEggText: [String] = ["Dismiss", "Dismiss", "Ok", "Fine", "I don't care", "Really?", "You've got to be joking", "Wow, the irony", "Android app?", "Congrats", "Noooo", "Yeah", "YES!", "Accept award", ":'(", "Yes, of course!"]

    @IBOutlet weak var outputname: UILabel!
    
    @IBAction func Switch(_ sender: UISwitch) {
        print("Switch working")
        
        if x < 15{
        let alertsocial = UIAlertController(title: "Tasks Notifications", message: myEasterEgg[x], preferredStyle: .alert)
        let actionsocial = UIAlertAction(title: myEasterEggText[x], style: .cancel, handler: nil)
        
        alertsocial.addAction(actionsocial)
        self.present(alertsocial, animated: true, completion: nil)
        
        x = x + 1
        }
        else if x == 15 {
            let alertsocial = UIAlertController(title: "Tasks Notifications", message: self.myEasterEgg[15], preferredStyle: .alert)
            let actionsocial1 = UIAlertAction(title: "Maybe later", style: .cancel, handler: nil)
            let actionsocial = UIAlertAction(title: self.myEasterEggText[15], style: .default, handler: {(action:UIAlertAction) in
                var url  = NSURL(string: "itms-apps://itunes.apple.com/us/app/temple-run/id420009108?mt=8")
                if UIApplication.shared.canOpenURL(url! as URL) {
                    UIApplication.shared.openURL(url! as URL)
                } else {
                    // FB is not installed, open in safari
                    UIApplication.shared.openURL(self.weburl as URL)
                }
        })
            
            alertsocial.addAction(actionsocial1)
            alertsocial.addAction(actionsocial)
            self.present(alertsocial, animated: true, completion: nil)
            x = 15
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        if let x = UserDefaults.standard.object(forKey: "myName") as? String
        {
            if x == "" {
                outputname.text = "Name not defined"
            }else {
                outputname.text = x
            }
        }
    }
}
