//
//  EmailNewsCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 06/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class EmailNewsCell: UITableViewCell{
    
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var readPost: UIView!
    @IBOutlet weak var Sender: UILabel!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var Date: UILabel!
    
    func displayContent(sender: String, title: String, description: String, date: String, postRead: Bool, cardColour: String){
        
        Sender.text = sender
        Title.text = title
        Description.text = description
        Date.text = date
        
        cornerView.layer.cornerRadius = Variables.cornerRadius
        cornerView.layer.masksToBounds = true
        
        readPost.makeCircular()
        
        readPost.isHidden = postRead
        
        if postRead == true{
            Sender.textColor = UIColor.lightGray
            Title.textColor = UIColor.darkGray
            Description.textColor = UIColor.lightGray
            Date.textColor = UIColor.darkGray
            cornerView.backgroundColor = UIColor.groupTableViewBackground
        }
    }
}
