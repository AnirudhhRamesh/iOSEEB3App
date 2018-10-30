//
//  WebsiteCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 02/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class WebsiteCell: UICollectionViewCell{
    
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var Banner: UIImageView!
    @IBOutlet weak var Title: UILabel!
    
    func displayContent(title: String, banner: UIImage){
        
        cornerView.layer.cornerRadius = Variables.cornerRadius
        cornerView.layer.masksToBounds = true
        
        Banner.image = banner
        Title.text = title
    }

}
