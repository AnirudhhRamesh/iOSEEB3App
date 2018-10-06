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
    @IBOutlet weak var websiteType: UILabel!
    
    func displayContent(banner: UIImage, title: String, websiteDescription: String, titleColor: String){
        
        Banner.image = banner
        Title.text = title
        websiteType.text = websiteDescription
        
        Title.textColor = UIColor.init(hexString: titleColor)
        
    }

}
