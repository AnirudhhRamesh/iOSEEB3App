//
//  CreditsViewController.swift
//  EEB3App
//
//  Created by RAMESH anirudhh on 11/09/2017.
//  Copyright © 2017 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class CreditsView: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
}
