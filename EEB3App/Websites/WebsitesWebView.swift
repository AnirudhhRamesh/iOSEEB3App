//
//  WebsitesWebViewViewController.swift
//  EEB3App
//
//  Created by RAMESH anirudhh on 11/08/17.
//  Copyright © 2017 RAMESH anirudhh. All rights reserved.
//

import UIKit

class WebsitesWebView: UIViewController {

    @IBOutlet weak var myWebView: UIWebView!
        
    @IBAction func credentialsTool(_ sender: Any)
    {
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
                self.performSegue(withIdentifier: "saveCredentials1", sender: self)
            })
            let actiondismiss = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)

            actionSheet.addAction(actiondismiss)
            actionSheet.addAction(actionSocial)
            self.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = websites[myIndex]
        let url = ["http://www.eeb3.eu/index.php?l=2", "https://sms.eursc.eu/login.php", "http://www.eeb3cde.eu/", "https://bissc.net", "https://ec.eeb3.eu/"]
        
        if myIndex == 1 {
            
            if let officeBool = UserDefaults.standard.object(forKey: "officeCredentials") as? Bool{
                if officeBool == true{
                    let URLFetcher = "http://bit.ly/Office365SMS"
                    let finalURL = URL(string: URLFetcher)
                    
                    myWebView.loadRequest(URLRequest(url: finalURL!))
                    
                    /*
                    if let emailCredential = UserDefaults.standard.object(forKey: "SMSEmail") as? String,
                        let passwordCredential = UserDefaults.standard.object(forKey: "SMSPassword") as? String{
                        
                        let finalURL = URL(string: URLFetcher)
                        
                        myWebView.loadRequest(URLRequest(url: finalURL!))
                        
                        var savedUsername = "peter"
                        var savedPassword = "Pan123"
                        //create js strings
                        var loadUsernameJS =
                            "var inputFields = document.querySelectorAll(\"input[type='text']\"); " +
                        "        for (var i = inputFields.length >>> 0; i--;) { inputFields[i].value = '\(savedUsername)';}"
                        var loadPasswordJS = "document.querySelectorAll(\"input[type='password']\").value ='\(savedPassword)'"
                        
                        //let script = "document.body.style.background = 'red'"
                        if let result = myWebView.stringByEvaluatingJavaScript(from: loadUsernameJS) {
                            print("result is \(result)")
                        }
                        
                        //autofill the form
                        myWebView.stringByEvaluatingJavaScript(from: loadUsernameJS)
                        myWebView.stringByEvaluatingJavaScript(from: loadPasswordJS)
 
 */
                    }
                else {
                    
                    let URLFetcher = "https://sms.eursc.eu/login.php"
                    let finalURL = URL(string: URLFetcher)
                    
                    myWebView.loadRequest(URLRequest(url: finalURL!))
                    
                    if let emailCredential = UserDefaults.standard.object(forKey: "SMSEmail") as? String,
                        let passwordCredential = UserDefaults.standard.object(forKey: "SMSPassword") as? String{
                        
                        let finalURL = URL(string: URLFetcher)
                        
                        myWebView.loadRequest(URLRequest(url: finalURL!))
                        /*
                        let script = "javascript: {" +
                            "document.getElementById('user_password').value = '"+passwordCredential+"';" + "document.getElementById('user_email').value = '"+emailCredential+"';" + "var frms = document.getElementsByName('login_form');" + "frms[0].submit(); };"
                        myWebView.stringByEvaluatingJavaScript(from: script)
                        
                        let credentialsJavascript = "javascript: {" +
                            "document.getElementById('user_password').value = '"+passwordCredential+"';" + "document.getElementById('user_email').value = '"+emailCredential+"';" + "var frms = document.getElementsByName('login_form');" + "frms[0].submit(); };"
                        */
                    }
                    else{
                        let finalURL = URL(string: URLFetcher)
                        
                        myWebView.loadRequest(URLRequest(url: finalURL!))
                    }
                }
            }
        }
        else {
        
        let URLFetcher = url[myIndex]

        let finalURL = URL(string: URLFetcher)
        
        myWebView.loadRequest(URLRequest(url: finalURL!))
        }
        
    }
}
