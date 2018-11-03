//
//  CreateGroup.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 30/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class CreateGroup: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var count = 2
    var taskArray: [String] = ["hey", "there"]
    var cellCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == count - 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "addNewTaskCell") as! AddNewTaskCell
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "newTaskCell") as! NewTaskCell
            if taskArray.count > indexPath.row{
                cell.taskField.text = taskArray[indexPath.row]
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == count - 1{
            cellCount = 0
            while cellCount < count - 1{
                let cell = tableView.cellForRow(at: IndexPath(row: cellCount, section: 0)) as! NewTaskCell
                taskArray.append(cell.taskField.text!)
                cellCount += 1
            }
            count += 1
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row != count - 1{
            return true
        }
        else{
            return false
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            tableView.beginUpdates()
            count -= 1
            taskArray.remove(at: indexPath.row)
            //Fix such that there is an array that removes the value for a certain indexPath.
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        }
    }
    
    @IBAction func createGroupTapped(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }
}
