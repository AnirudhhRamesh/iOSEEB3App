//
//  AbsencesViewController.swift
//  EEB3App
//
//  Created by RAMESH anirudhh on 09/09/2017.
//  Copyright © 2017 RAMESH anirudhh. All rights reserved.
//

import UIKit

class AbsencesViewController: UIViewController {
    
    @IBAction func credentialsTool(_ sender: Any) {
        if let emailCredential = UserDefaults.standard.object(forKey: "SMSEmail") as? String,
            let passwordCredential = UserDefaults.standard.object(forKey: "SMSPassword") as? String{
            
            let actionSheet = UIAlertController(title: "Copy your credentials", message: "Copy your SMS username and/or password to your clipboard", preferredStyle: .alert)
            let actiondismiss = UIAlertAction(title: "Username", style: .default, handler: { (action:UIAlertAction) in
                UIPasteboard.general.string = emailCredential
            })
            let actionSocial = UIAlertAction(title: "Password", style: .default, handler: { (action:UIAlertAction) in
                UIPasteboard.general.string = passwordCredential
            })
            actionSheet.addAction(actiondismiss)
            actionSheet.addAction(actionSocial)
            self.present(actionSheet, animated: true, completion: nil)
        }
        else{
            let actionSheet = UIAlertController(title: "No available credentials", message: "You haven't saved your credentials in the app", preferredStyle: .alert)
            let actionSocial = UIAlertAction(title: "Save credentials", style: .default, handler: { (action:UIAlertAction) in
                //Perform segue
                self.performSegue(withIdentifier: "saveCredentials2", sender: self)
            })
            let actiondismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            
            actionSheet.addAction(actiondismiss)
            actionSheet.addAction(actionSocial)
            self.present(actionSheet, animated: true, completion: nil)
        }
    }
    

    @IBOutlet weak var myWebView: UIWebView!
    
    override func viewDidLoad() {
        if let officeBool = UserDefaults.standard.object(forKey: "officeCredentials") as? Bool{
            if officeBool == true{
                let URLFetcher = "http://bit.ly/Office365SMS"
                let finalURL = URL(string: URLFetcher)
                
                myWebView.loadRequest(URLRequest(url: finalURL!))
            }
            else {
                
                let URLFetcher = "https://sms.eursc.eu/login.php"
                let finalURL = URL(string: URLFetcher)
                
                myWebView.loadRequest(URLRequest(url: finalURL!))
                
                if let emailCredential = UserDefaults.standard.object(forKey: "SMSEmail") as? String,
                    let passwordCredential = UserDefaults.standard.object(forKey: "SMSPassword") as? String{
                    
                    let finalURL = URL(string: URLFetcher)
                    
                    myWebView.loadRequest(URLRequest(url: finalURL!))
                }
                else{
                    let finalURL = URL(string: URLFetcher)
                    
                    myWebView.loadRequest(URLRequest(url: finalURL!))
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
