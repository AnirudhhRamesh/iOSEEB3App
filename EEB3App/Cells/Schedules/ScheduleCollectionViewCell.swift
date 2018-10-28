//
//  TableViewCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 20/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

var selectedPeriod = (0,0) //(CollectionViewCell#, TableViewRow#)

class ScheduleCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tableView.delegate = self as UITableViewDelegate
        tableView.dataSource = self as UITableViewDataSource
    }
    
    let MinHeight: CGFloat = 20
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let tHeight = tableView.bounds.height
        
        let temp = tHeight/CGFloat(10)
        
        return temp > MinHeight ? temp : MinHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 3{
            let cell = tableView.dequeueReusableCell(withIdentifier: "shortBreak") as! UITableViewCell
            return cell
        }
        if indexPath.row == 6{
            let cell = tableView.dequeueReusableCell(withIdentifier: "break") as! UITableViewCell
            return cell
        }
        else{
        let cell = tableView.dequeueReusableCell(withIdentifier: "period") as! ScheduleTableViewCell
            cell.displayContent(title: "Free", room: "----", period: "P1", bgColor: "#ffffff")
        return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPeriod = (0, indexPath.row)
        print(selectedPeriod)
        //performSegue(withIdentifier: "addPeriod", sender: self)
    }
}
