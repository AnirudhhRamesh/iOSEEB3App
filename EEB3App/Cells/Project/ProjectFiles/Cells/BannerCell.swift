//
//  BannerCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 29/12/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class BannerCell: UITableViewCell{
    
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var Banner: UIImageView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var TextLabel: UILabel!
    
    
    func displayContent(banner: UIImage, title: String, description: String, text: String){
        cornerView.layer.cornerRadius = 15
        cornerView.layer.masksToBounds = true
        
        Banner.image = banner
        Title.text = title
        Description.text = description
        TextLabel.text = text
    }
}
