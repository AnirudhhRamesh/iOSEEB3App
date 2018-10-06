//
//  LoginContainer.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 29/09/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class LoginContainer: UIViewController{
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 15
        loginButton.layer.masksToBounds = true
        
    }
    
}
