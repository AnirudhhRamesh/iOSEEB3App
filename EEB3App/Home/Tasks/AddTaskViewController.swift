//
//  AddTaskViewController.swift
//  EEB3App
//
//  Created by RAMESH anirudhh on 09/08/17.
//  Copyright © 2017 RAMESH anirudhh. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    @IBAction func closeView(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBOutlet weak var priorityIndicator: UILabel!
    
    @IBAction func highButton(_ sender: Any) {
        priorityIndicator.text = "High"
    }
    @IBAction func mediumButton(_ sender: Any) {
        priorityIndicator.text = "Medium"
    }
    @IBAction func lowButton(_ sender: Any) {
        priorityIndicator.text = "Low"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    @IBOutlet weak var input: UITextField!
    @IBAction func addItem(_ sender: Any)
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let task = Task(context: context)
        
        if (input.text != "")
        {
            if priorityIndicator.text == "High"
            {
                task.name = "📕" + input.text!
                task.isImportant = false
            }
            
            else if priorityIndicator.text == "Medium"
            {
                task.name = "📙" + input.text!
                task.isImportant = false
            }
            
            else if priorityIndicator.text == "Low"
            {
                task.name = "📗" + input.text!
                task.isImportant = false
            }
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            self.navigationController?.popViewController(animated: true)

        }
        else
        {
            self.navigationController?.popViewController(animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
