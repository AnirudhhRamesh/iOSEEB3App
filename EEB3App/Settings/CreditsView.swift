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

    @IBOutlet weak var cornerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        cornerView.layer.cornerRadius = Variables.cornerRadius
        cornerView.layer.masksToBounds = true
        
    }
    
}
