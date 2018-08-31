//
//  ProjectsTabBarController.swift
//  EEB3App
//
//  Created by RAMESH anirudhh on 20/10/2017.
//  Copyright © 2017 RAMESH anirudhh. All rights reserved.
//

import UIKit

class ProjectsTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.title = "Projects"
        tabBarController?.navigationController?.isNavigationBarHidden=false;
        tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Right Button Title", style: UIBarButtonItemStyle.plain, target: self, action: Selector(("rightButtonFunction")))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.title = "Projects"
        tabBarController?.navigationController?.isNavigationBarHidden=false;
        tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Right Button Title", style: UIBarButtonItemStyle.plain, target: self, action: Selector(("rightButtonFunction")))
    }

    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.title = "Projects"
        tabBarController?.navigationController?.isNavigationBarHidden=false;
        tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Right Button Title", style: UIBarButtonItemStyle.plain, target: self, action: Selector(("rightButtonFunction")))
    }
}
