//
//  SettingsTable.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 14/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class SettingsTable: UITableViewCell, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var tableIcon: UIImageView!
    @IBOutlet weak var tableTitle: UILabel!
    @IBOutlet weak var cornerView: UIView!
    
    var cellNumber = -1
    var TableViewSettingsStruct = SettingsStruct()
    var heightOfTableViewConstraint = NSLayoutConstraint()
    func displayContent(tableViewTitle: String, tableViewIcon: UIImage, settingsStruct: SettingsStruct){
        cornerView.layer.cornerRadius = Variables.cornerRadius
        cornerView.layer.masksToBounds = true
        tableTitle.text = tableViewTitle
        tableIcon.image = tableViewIcon
        TableViewSettingsStruct = settingsStruct
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Initialization
        myTableView.delegate = self
        myTableView.dataSource = self
        
        // Class variable heightOfTableViewConstraint set to 1000
        heightOfTableViewConstraint = NSLayoutConstraint(item: self.myTableView, attribute: .height, relatedBy: .equal, toItem: myTableView, attribute: .height, multiplier: 0.0, constant: 800)
        myTableView.addConstraint(heightOfTableViewConstraint)
        myTableView.layoutIfNeeded()
        
        UIView.animate(withDuration: 0, animations: {
            self.myTableView.layoutIfNeeded()
        }) { (complete) in
            var heightOfTableView: CGFloat = 0.0
            // Get visible cells and sum up their heights
            let cells = self.myTableView.visibleCells
            for cell in cells {
                heightOfTableView += cell.frame.height
            }
            // Edit heightOfTableViewConstraint's constant to update height of table view
            self.heightOfTableViewConstraint.constant = heightOfTableView
        }
        self.myTableView.reloadData()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableViewSettingsStruct.cellType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("Running tableView Code")
        while cellNumber < TableViewSettingsStruct.cellType.count{
            cellNumber += 1
            print("The cellNumber is \(cellNumber) and tableViewcellNumber is \(TableViewSettingsStruct.cellType.count)")
            print(TableViewSettingsStruct.cellType[cellNumber])
            switch TableViewSettingsStruct.cellType[cellNumber]{
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! userCell
                cell.displayContent(label: TableViewSettingsStruct.textArray[cellNumber])
                print("userCell")
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "segueCell") as! segueCell
                cell.displayContent(label: TableViewSettingsStruct.textArray[cellNumber])
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as! switchCell
                cell.displayContent(label: TableViewSettingsStruct.textArray[cellNumber], switchState: TableViewSettingsStruct.switchStateArray[cellNumber])
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "logoutCell") as! logoutCell
                cellNumber += 1
                return cell
            default:
                //Error occurred, print(error)
                print("An error occurred fetching the cell")
                let cell = tableView.dequeueReusableCell(withIdentifier: "errorCell") as! UITableViewCell
                cell.textLabel?.text = "An error occurred fetching the cell"
                return cell
            }
        }
        if TableViewSettingsStruct.cellType == nil{
            let cell = tableView.dequeueReusableCell(withIdentifier: "errorCell") as! UITableViewCell
            cell.textLabel?.text = "An error occurred fetching the cell"
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "errorCell") as! UITableViewCell
            cell.textLabel?.text = "An error occurred fetching the cell"
            return cell
        }
    }
}
