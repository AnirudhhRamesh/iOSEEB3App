//
//  segueCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 14/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class segueCell: UITableViewCell{
    
    @IBOutlet weak var Title: UILabel!
    
    func displayContent(label: String){
        Title.text = label
    }
}
