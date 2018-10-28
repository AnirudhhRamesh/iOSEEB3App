//
//  TaskCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 28/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class TaskCell: UITableViewCell{
    
    @IBOutlet weak var TaskLabel: UILabel!
    @IBOutlet weak var taskAlert: UIImageView!
    
    
    func displayContent(task: String, priority: Bool, isCompleted: Bool, indexPath: Int){
        TaskLabel.text = task
        taskAlert.isHidden = !priority
    }
}
