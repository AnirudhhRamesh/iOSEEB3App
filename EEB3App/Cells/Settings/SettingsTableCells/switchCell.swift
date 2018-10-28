//
//  switchCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 14/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class switchCell: UITableViewCell{
    
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Switch: UISwitch!
    
    func displayContent(label: String, switchState: Bool){
        Title.text = label
        Switch.setOn(switchState, animated: true)
    }
}
