//
//  TasksViewController.swift
//  EEB3App
//
//  Created by RAMESH anirudhh on 09/08/17.
//  Copyright © 2017 RAMESH anirudhh. All rights reserved.
//

import UIKit

var tasks : [Task] = []
var highPriority: [String] = []
var medPriority: [String] = []
var lowPriority: [String] = []
var AllTasks: [String] = []
var FinalTasks: [String] = []

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBAction func closeActionButton(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBOutlet weak var myTableView: UITableView!
    
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
        
        /*
        let task1 = Task(context: context)
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore  {
            print("Not first launch.")
        } else {
            print("First launch, setting UserDefault.")
            
            task1.name = "📕" + "Swipe on a task to delete it!"
            task1.isImportant = false
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            UserDefaults.standard.set(true, forKey: "launchedBefore")
        }*/
        
        do{
        tasks = try context.fetch(Task.fetchRequest())
        }
        catch{
            print("Fetching Failed")
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        
        AllTasks = []
        FinalTasks = []
        highPriority = []
        medPriority = []
        lowPriority = []
        
        for i in tasks{
            AllTasks.append(i.name!)
        }
        if AllTasks != nil{
            var x = 0
            for i in AllTasks{
            if AllTasks[x].range(of: "📕") != nil{
                highPriority.append(i)
                x = x + 1
            }
            else if AllTasks[x].range(of: "📙") != nil{
                medPriority.append(i)
                x = x + 1
            }
            else if AllTasks[x].range(of: "📗") != nil{
                lowPriority.append(i)
                x = x + 1
            }
            }
        }
        
        for a in highPriority{
            FinalTasks.append(a)
        }
        
        for b in medPriority{
            FinalTasks.append(b)
        }
        
        for c in lowPriority{
            FinalTasks.append(c)
        }
        
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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
