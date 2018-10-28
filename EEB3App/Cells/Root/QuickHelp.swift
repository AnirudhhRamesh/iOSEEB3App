//
//  QuickHelpCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 29/09/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class QuickHelp: UICollectionViewCell{
    
    @IBOutlet weak var CircularCardView: UIView!
    @IBOutlet weak var CardView: CardView!
    @IBOutlet weak var Icon: UIImageView!
    @IBOutlet weak var Title: UILabel!
    
    func displayContent(icon: UIImage, title: String, color: String){
        
        CircularCardView.makeCircular()
        
        CardView.backgroundColor = UIColor(hexString: color)
        Icon.image = icon
        Title.text = title
        
    }
    
}
