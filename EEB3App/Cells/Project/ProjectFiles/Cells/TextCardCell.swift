//
//  TextCardCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 29/12/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class TextCardCell: UITableViewCell{
    
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var TextLabel: UILabel!
    
    func displayContent(title: String, text: String){
        Title.text = title
        TextLabel.text = text
    }
}
