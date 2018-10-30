//
//  LoginSchoolCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 29/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class LoginSchoolCell: UITableViewCell{
    
    @IBOutlet weak var schoolLabel: UILabel!
    
    func displaySchool(schoolName: String){
        schoolLabel.text = schoolName
    }
}
