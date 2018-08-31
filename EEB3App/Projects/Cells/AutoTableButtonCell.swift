//
//  AutoTableButtonCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 27/03/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class AutoTableButtonCell: UITableViewCell {
    
    @IBOutlet weak var AutoTableButtonTitle: UILabel!
    @IBOutlet weak var AutoTableButton: UIButton!
    
    @IBOutlet weak var AutoTableButtonContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}


