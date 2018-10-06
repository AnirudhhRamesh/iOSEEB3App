//
//  ProjectIconCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 02/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class ProjectIconCell: UICollectionViewCell{
    
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var Banner: UIImageView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var projectType: UILabel!
    
    func displayContent(banner: UIImage, title: String, projectDescription: String, color: String){
        
        cornerView.layer.cornerRadius = 15
        cornerView.layer.masksToBounds = true
        
        Banner.image = banner
        Title.text = title
        projectType.text = projectDescription
        
        Title.textColor = UIColor.init(hexString: color)
        
    }
    
}
