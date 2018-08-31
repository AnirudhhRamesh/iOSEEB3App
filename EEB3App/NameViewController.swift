//
//  NameViewController.swift
//  EEB3App
//
//  Created by RAMESH anirudhh on 10/08/17.
//  Copyright © 2017 RAMESH anirudhh. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {

    @IBAction func NameCloser(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBOutlet weak var output: UILabel!
    @IBOutlet weak var input: UITextField!
    
    @IBAction func action(_ sender: Any) {
        output.text = input.text
        UserDefaults.standard.set(input.text, forKey: "myName")
        output.text = "Hello " + output.text!
        input.text = ""
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let x = UserDefaults.standard.object(forKey: "myName") as? String
        {
            output.text = x
            output.text = "Hello " + output.text!
        }
    }
}
