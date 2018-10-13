//
//  ProjectViewUpdateCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 05/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class ProjectViewUpdateCell: UITableViewCell{
    
    
    @IBOutlet weak var Icon: UIImageView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Description: UILabel!
    
    func displayContent(cellIcon: UIImage, cellTitle: String, cellDescription: String){
        Icon.image = cellIcon
        Title.text = cellTitle
        Description.text = cellDescription
    }
}
