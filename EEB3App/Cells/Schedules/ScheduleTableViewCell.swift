//
//  ScheduleTableViewCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 20/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class ScheduleTableViewCell: UITableViewCell{
    
    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var courseRoom: UILabel!
    @IBOutlet weak var coursePeriod: UILabel!
    
    func displayContent(title: String, room: String, period: String, bgColor: String){
        courseTitle.text = title
        courseRoom.text = room
        coursePeriod.text = period
        cardView.backgroundColor = UIColor(hexString: bgColor)
    }
}
