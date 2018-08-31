//
//  LoginScreenViewController.swift
//  EEB3App
//
//  Created by RAMESH anirudhh on 31/10/2017.
//  Copyright © 2017 RAMESH anirudhh. All rights reserved.
//

import UIKit
import FirebaseDatabase


var Users: [String] = []
var Passwords: [String] = []

class NotificationCenterLogin: UIViewController {
    
    var handle: DatabaseHandle?
    var ref: DatabaseReference?
    
    
    var saveCredents: Bool = false
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var saveCredentials: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let check = UserDefaults.standard.object(forKey: "saveCredentials") as? Bool{
        saveCredents = check
        }
        else{
            saveCredents = false
        }
        
        if saveCredents == true
        {
            saveCredentials.isOn = true
        if let x = UserDefaults.standard.object(forKey: "myEmail") as? String
        {
            emailField.text = x
        }
        if let y = UserDefaults.standard.object(forKey: "myPassword") as? String
        {
            passwordField.text = y
        }
        }
        else{
            print("Don't save credentials")
        }
        
        ref = Database.database().reference()
        handle = ref?.child("Notification Users").observe(.childAdded, with: { (snapshot) in
            if let item = snapshot.value as? String
            {
                let itemKey = snapshot.key
                print(itemKey)
                if itemKey.range(of: "user") != nil
                {
                    Users.append(item)
                }
                if itemKey.range(of: "password") != nil
                {
                    Passwords.append(item)
                    
                }
            }
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func LoginTapped(_ sender: Any)
    {
        let email = emailField.text
        let password = passwordField.text
        
        if (email == ""){
            print("You haven't filled in your username!")
            let alertsocial = UIAlertController(title: "Invalid Email address", message: "You haven't filled in your email address!", preferredStyle: .alert)
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
            
            if Users.contains(email!) && Passwords.contains(password!){
                UserDefaults.standard.set(email, forKey: "myEmail")
                UserDefaults.standard.set(password, forKey: "myPassword")
                performSegue(withIdentifier: "NotificationAccessGranted", sender: self)
                
                if saveCredentials.isOn{
                    UserDefaults.standard.set(true, forKey: "saveCredentials")
                }
                else{
                    UserDefaults.standard.set(false, forKey: "saveCredentials")
                }
            }
            else {
                print("Your email address or password is incorrect")
                let alertsocial = UIAlertController(title: "Email or password is incorrect", message: "Your email address or password seems to be incorrect", preferredStyle: .alert)
                let actionsocial = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
                
                alertsocial.addAction(actionsocial)
                self.present(alertsocial, animated: true, completion: nil)
            }
        }
        

        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

