//
//  MainTabBarController.swift
//  EEB3App
//
//  Created by RAMESH anirudhh on 11/09/2017.
//  Copyright © 2017 RAMESH anirudhh. All rights reserved.
//

import UIKit

var freshLaunch = true

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if freshLaunch == true {
            freshLaunch = false
            self.tabBarController?.selectedIndex = 3 // 5th tab
        }
    }
    
}
