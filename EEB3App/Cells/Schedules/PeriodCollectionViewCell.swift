//
//  PeriodCollectionViewCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 20/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class PeriodCollectionViewCell: UICollectionViewCell{
    
    @IBOutlet weak var courseBackground: CardView!
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var coursePeriod: UILabel!
    @IBOutlet weak var courseRoom: UILabel!
    
    func displayContent(title: String, period: String, room: String, bgColour: String){
        courseTitle.text = title
        coursePeriod.text = period
        courseRoom.text = room
        courseBackground.backgroundColor = UIColor(hexString: bgColour)
    }
}
