//
//  logoutCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 14/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class logoutCell: UITableViewCell{
    
    @IBOutlet weak var Title: UIButton!
    
    func displayContent(label: String){
        Title.titleLabel?.text = label
    }
}
