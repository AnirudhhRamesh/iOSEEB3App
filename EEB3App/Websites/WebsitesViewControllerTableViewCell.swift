//
//  WebsitesViewControllerTableViewCell.swift
//  EEB3App
//
//  Created by RAMESH anirudhh on 10/08/17.
//  Copyright © 2017 RAMESH anirudhh. All rights reserved.
//

import UIKit

class WebsitesViewControllerTableViewCell: UITableViewCell {

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myLabelDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
