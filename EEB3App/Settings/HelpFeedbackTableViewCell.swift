//
//  HelpFeedbackTableViewCell.swift
//  EEB3App
//
//  Created by RAMESH anirudhh on 13/10/2017.
//  Copyright © 2017 RAMESH anirudhh. All rights reserved.
//

import UIKit

class HelpFeedbackTableViewCell: UITableViewCell {

    @IBOutlet weak var labelDescription: UILabel!
    
    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
