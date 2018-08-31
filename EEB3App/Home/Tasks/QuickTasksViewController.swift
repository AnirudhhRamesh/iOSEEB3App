//
//  QuickTasksViewController.swift
//  EEB3App
//
//  Created by RAMESH anirudhh on 28/08/2017.
//  Copyright © 2017 RAMESH anirudhh. All rights reserved.
//

import UIKit

class QuickTasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var myTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tasks.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell =  UITableViewCell()
        
        let task = tasks[indexPath.row]
        
        cell.textLabel?.text = task.name!
        
        return cell
    }
    
    func getData()
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            tasks = try context.fetch(Task.fetchRequest())
        }
        catch{
            print("Fetching Failed")
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        
        myTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete
        {
            let task = tasks[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                tasks = try context.fetch(Task.fetchRequest())
            }
            catch{
                print ("Fetching Failed")
            }
        }
        myTableView.reloadData()
    }


    override func viewDidAppear(_ animated: Bool) {
        myTableView.reloadData()
    }
}
