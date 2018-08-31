//
//  AutoTableButtonCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 27/03/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class NotificationCell: UITableViewCell {
    
    @IBOutlet weak var myNotificationCardView: CardView!
    @IBOutlet weak var myNotificationTitle: UILabel!
    @IBOutlet weak var myNotificationDescription: UILabel!
    @IBOutlet weak var myNotificationDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}



