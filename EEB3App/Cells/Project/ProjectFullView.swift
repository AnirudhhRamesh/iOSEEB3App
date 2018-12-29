//
//  ProjectFullView.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 05/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class ProjectFullView: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{ //if importantUpdates.count != false{}
        let cell = tableView.dequeueReusableCell(withIdentifier: "updateCell") as! ProjectViewUpdateCell
        
            cell.displayContent(cellIcon: UIImage(named: "alert-circle")!, cellTitle: "Redesigning the iOS EEB3 App", cellDescription: "Please be aware that the iOS EEB3 App is currenty being fully updated with the latest design trends and features.")
        return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "collectionCell") as! ProjectViewSectionCell
            
            cell.displayContent(cellTitle: "School Events", cellDescription: "Redundant")
            
            return cell
        }
    }
    
}
