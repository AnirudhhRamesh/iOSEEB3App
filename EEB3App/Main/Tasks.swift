//
//  Tasks.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 28/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 11.0, *)
class Tasks: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var groupCornerView: UIView!
    @IBOutlet weak var tasksCornerView: UIView!
    
    let count = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.collectionViewLayout = columnLayout
        collectionView?.contentInsetAdjustmentBehavior = .always
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        groupCornerView.layer.cornerRadius = 15
        groupCornerView.layer.masksToBounds = true
        
        tasksCornerView.layer.cornerRadius = 15
        tasksCornerView.layer.masksToBounds = true
    }
    
    //Create a new task
    @IBAction func newObjectTapped(_ sender: Any)
    {
        let myalert = UIAlertController(title: "Create a New Item", message: "Select whether you would like to create a new task or a new group", preferredStyle: UIAlertControllerStyle.alert)
        
        myalert.addAction(UIAlertAction(title: "Group", style: .default) { (action:UIAlertAction!) in
            self.performSegue(withIdentifier: "createGroupSegue", sender: self)
        })
        myalert.addAction(UIAlertAction(title: "Task", style: .default) { (action:UIAlertAction!) in
            self.performSegue(withIdentifier: "createTaskSegue", sender: self)
        })
        
        self.present(myalert, animated: true)
    }
    
    
    let columnLayout = GroupColumnFlowLayout(
        cellsPerRow: 3,
        minimumInteritemSpacing: 0,
        minimumLineSpacing: 0,
        sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    )
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if count == 0{
            return 1
        }
        else{
            return count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if count == 0{
            let addTaskGroupCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addTaskGroupCell", for: indexPath) as! AddTaskGroupCell
            //Create an alert that informs the user what one can do by using a grouped task
            //Once the message has been read, save a value to the user shared defaults
            return addTaskGroupCell
        }
        else{
            if indexPath.row == count - 1{
                let addTaskGroupCell = collectionView.dequeueReusableCell(withReuseIdentifier: "addTaskGroupCell", for: indexPath) as! AddTaskGroupCell
                return addTaskGroupCell
            }
            else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "taskGroupCell", for: indexPath) as! TaskGroupCell
                cell.displayContent(title: "Integrated Sciences", completedTasks: 4, totalTasks: 12)
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell") as! TaskCell
        cell.displayContent(task: "Finish German Exercises: S.34 Ex 3.4 und S.45 Ex 12.5", groupColour: "#3f51b5", isCompleted: false, indexPath: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == count - 1{
            //Here, segue to a new view to create the new Tasks Group
        }
    }
}
