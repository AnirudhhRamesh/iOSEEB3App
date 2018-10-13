//
//  Websites.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 02/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class Websites: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            //if udateAvailable {}
            let cell = tableView.dequeueReusableCell(withIdentifier: "updateCell") as! ProjectViewUpdateCell
            cell.displayContent(cellIcon: UIImage(named: "info")!, cellTitle: "\(Variables.appName) under development", cellDescription: "The \(Variables.appName) is currently under development, certain functions might not work properly.")
            return cell
            //else{}
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "websiteSectionCell") as! WebsiteSectionCell
            cell.displayContent(sectionTitle: "School") //, sectionDictionary: websiteDictionary. Parse this later on in the WebsiteSectionCell
            return cell
        }
    }
    
}
