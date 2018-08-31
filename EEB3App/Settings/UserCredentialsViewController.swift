//
//  LoginScreenViewController.swift
//  EEB3App
//
//  Created by RAMESH anirudhh on 31/10/2017.
//  Copyright © 2017 RAMESH anirudhh. All rights reserved.
//

import UIKit

class UserCredentialsViewController: UIViewController {
    
    var saveCredents: Bool = true
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var officeSwitch: UISwitch!
    
    @IBAction func officeSwitchtapped(_ sender: Any) {
        if officeSwitch.isOn{
            UserDefaults.standard.set(true, forKey: "officeCredentials")
            let alertsocial = UIAlertController(title: "Office 365 enabled", message: "SMS will load Office365 directly for login. This is for users who do have an @------.eursc.eu account.", preferredStyle: .alert)
            let actionsocial = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            
            alertsocial.addAction(actionsocial)
            self.present(alertsocial, animated: true, completion: nil)
        }
        else{
            UserDefaults.standard.set(false, forKey: "officeCredentials")
            let alertsocial = UIAlertController(title: "Office 365 disabled", message: "SMS will load sms.eursc.eu directly for login. This is for users who don't have an @------.eursc.eu account.", preferredStyle: .alert)
            let actionsocial = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            
            alertsocial.addAction(actionsocial)
            self.present(alertsocial, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let check = UserDefaults.standard.object(forKey: "officeCredentials") as? Bool{
            saveCredents = check
        }
        else{
            saveCredents = false
        }
        
        if saveCredents == true
        {
            officeSwitch.isOn = true
            if let x = UserDefaults.standard.object(forKey: "SMSEmail") as? String
            {
                emailField.text = x
            }
            if let y = UserDefaults.standard.object(forKey: "SMSPassword") as? String
            {
                passwordField.text = y
            }
        }
        else{
            officeSwitch.isOn = false
            if let x = UserDefaults.standard.object(forKey: "SMSEmail") as? String
            {
                emailField.text = x
            }
            if let y = UserDefaults.standard.object(forKey: "SMSPassword") as? String
            {
                passwordField.text = y
            }
        }
    }
    
    @IBAction func saveCredentials(_ sender: Any)
    {
        let email = emailField.text
        let password = passwordField.text
        
        if (email == ""){
            print("You haven't entered an email address!")
            let alertsocial = UIAlertController(title: "Invalid Email address", message: "You haven't entered in an email address!", preferredStyle: .alert)
            let actionsocial = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            
            alertsocial.addAction(actionsocial)
            self.present(alertsocial, animated: true, completion: nil)
        }
        else if (password == ""){
            print("You haven't filled in your password!")
            let alertsocial = UIAlertController(title: "Invalid Password", message: "You haven't filled in your password!", preferredStyle: .alert)
            let actionsocial = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            
            alertsocial.addAction(actionsocial)
            self.present(alertsocial, animated: true, completion: nil)
        }
        else if (email == "") && (password == ""){
            print("You haven't filled in your username or password")
            let alertsocial = UIAlertController(title: "Invalid Email and Password", message: "You haven't filled in your email address or password!", preferredStyle: .alert)
            let actionsocial = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            
            alertsocial.addAction(actionsocial)
            self.present(alertsocial, animated: true, completion: nil)
        }
            
        else if (email != "") && (password != ""){
            print("Email and password has been entered")
            
            if email?.range(of: "@") != nil{
            
                UserDefaults.standard.set(email, forKey: "SMSEmail")
                UserDefaults.standard.set(password, forKey: "SMSPassword")
                if officeSwitch.isOn{
                    UserDefaults.standard.set(true, forKey: "officeCredentials")
                }
                else{
                    UserDefaults.standard.set(false, forKey: "officeCredentials")
            }
            
            let actionSheet = UIAlertController(title: "Credentials successfully saved", message: "You have successfully saved your user credentials", preferredStyle: .alert)
            let actionSocial = UIAlertAction(title: "Dismiss", style: .default, handler: { (action:UIAlertAction) in
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
            })
            actionSheet.addAction(actionSocial)
            self.present(actionSheet, animated: true, completion: nil)
            }
            else{
                let actionSheet = UIAlertController(title: "Invalid email format", message: "Your email format is invalid", preferredStyle: .alert)
                let actionSocial = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                actionSheet.addAction(actionSocial)
                self.present(actionSheet, animated: true, completion: nil)
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
