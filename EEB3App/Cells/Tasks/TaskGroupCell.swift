//
//  TaskGroupCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 28/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class TaskGroupCell: UICollectionViewCell{
    
    @IBOutlet weak var GroupTitle: UILabel!
    @IBOutlet weak var TasksCompleted: UILabel!
    @IBOutlet weak var TaskProgress: UIProgressView!
    @IBOutlet weak var cornerView: UIView!
    
    
    func displayContent(title: String, completedTasks: Int, totalTasks: Int){
        cornerView.layer.cornerRadius = 15
        cornerView.layer.masksToBounds = true
        
        GroupTitle.text = title
        TasksCompleted.text = "\(completedTasks) of \(totalTasks) tasks completed"
        TaskProgress.setProgress(Float(completedTasks)/Float(totalTasks), animated: true)
    }
}
