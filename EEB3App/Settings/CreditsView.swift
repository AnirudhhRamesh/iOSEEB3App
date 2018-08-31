//
//  CreditsViewController.swift
//  EEB3App
//
//  Created by RAMESH anirudhh on 11/09/2017.
//  Copyright © 2017 RAMESH anirudhh. All rights reserved.
//

import UIKit

let nameCrediters = ["Anirudhh Ramesh", "", "", "", ""]
let jobCrediters = ["Chief Developer", "", "", "", ""]


class CreditsViewController: UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func emailTapped(_ sender: Any) {
        var email: String = "rameshan@student.eursc.eu"
        
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
            print(url)
    }
        else{
            print("error opening email address")
        }
    }
    
}
