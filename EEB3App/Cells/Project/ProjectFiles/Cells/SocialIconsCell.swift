//
//  SocialIconsCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 29/12/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class SocialIconsCell: UITableViewCell{
    
    @IBOutlet weak var Icon1: UIButton!
    @IBOutlet weak var Icon2: UIButton!
    @IBOutlet weak var Icon3: UIButton!
    @IBOutlet weak var Icon4: UIButton!
    
    func displayContent(title1: String, title2:String, title3: String, title4: String){
        Icon1.setTitle(title1, for: .normal)
        Icon2.setTitle(title2, for: .normal)
        Icon3.setTitle(title3, for: .normal)
        Icon4.setTitle(title4, for: .normal)
    }
}

