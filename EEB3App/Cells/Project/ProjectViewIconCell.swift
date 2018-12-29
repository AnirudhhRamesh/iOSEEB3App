//
//  ProjectViewIconCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 05/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class ProjectViewIconCell: UICollectionViewCell{
    
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var Banner: UIImageView!
    @IBOutlet weak var Title: UILabel!
    
    func displayContent(banner: UIImage, title: String){
        
        cornerView.layer.cornerRadius = 15
        cornerView.layer.masksToBounds = true
        
        Banner.image = banner
        Title.text = title
    }
    
}
