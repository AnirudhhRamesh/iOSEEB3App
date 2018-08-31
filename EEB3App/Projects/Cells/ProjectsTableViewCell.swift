//
//  ProjectsTableViewCell.swift
//  EEB3App
//
//  Created by RAMESH anirudhh on 26/08/2017.
//  Copyright © 2017 RAMESH anirudhh. All rights reserved.
//

import UIKit

class ProjectsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myImageproject: UIImageView!
    @IBOutlet weak var myLabelproject: UILabel!
    @IBOutlet weak var myLabelDescriptionproject: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
