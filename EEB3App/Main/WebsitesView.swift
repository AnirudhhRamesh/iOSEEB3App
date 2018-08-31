//
//  WebsitesViewController.swift
//  EEB3App
//
//  Created by RAMESH anirudhh on 10/08/17.
//  Copyright © 2017 RAMESH anirudhh. All rights reserved.
//

import UIKit

let websites = ["EEB3", "SMS", "Pupils' Committee", "BISSC", "Events Committee"]
let websitesDescript = ["The official website of the European School of Brussels  III", "All your grades, calendars and timetables in one website", "The EEB3's official students' committee, which proceeds to form innovations to the school", "The committee of pupils' representatives from the international schools of Brussels", "The committee that works together to enrich the school"]
var myIndex = 0

class WebsitesView: UIViewController, UITableViewDataSource, UITableViewDelegate {

    struct Objects {
        var sectionName : String!
        var sectionObjects : [String]!
        var sectionDescriptions : [String]!
    }
    
    var objectsArray = [Objects]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        objectsArray = [Objects(sectionName: "School", sectionObjects: ["EEB3", "SMS"], sectionDescriptions: ["The official website of the European School of Brussels  III", "All your grades, calendars and timetables in one website"]), Objects(sectionName: "Committee", sectionObjects: ["Pupils' Committee", "BISSC", "Events Committee"], sectionDescriptions: ["The EEB3's official students' committee, which proceeds to form innovations to the school", "The committee of pupils' representatives from the international schools of Brussels", "The committee that works together to enrich the school"])]
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WebsitesViewControllerTableViewCell
        
        cell.myLabel.text = objectsArray[indexPath.section].sectionObjects[indexPath.row]
        cell.myLabelDescription.text = objectsArray[indexPath.section].sectionDescriptions[indexPath.row]
        
        //cell.myLabelDescriptionproject.text = projectsDescript[indexPath.row]
        cell.myImage.image = UIImage(named: objectsArray[indexPath.section].sectionObjects[indexPath.row] + ".png")
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return objectsArray[section].sectionObjects.count
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int
    {
        return objectsArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return objectsArray[section].sectionName
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        if objectsArray[indexPath.section].sectionObjects[indexPath.row] == "EEB3"
        {
            myIndex = 0
        }
        else if objectsArray[indexPath.section].sectionObjects[indexPath.row] == "SMS"
        {
            myIndex = 1
        }
        else if objectsArray[indexPath.section].sectionObjects[indexPath.row] == "Pupils' Committee"
        {
            myIndex = 2
        }
        else if objectsArray[indexPath.section].sectionObjects[indexPath.row] == "BISSC"
        {
            myIndex = 3
        }
        else if objectsArray[indexPath.section].sectionObjects[indexPath.row] == "Events Committee"
        {
            myIndex = 4
        }
        else {
            myIndex = 0
        }
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "websiteSegue", sender: self)
    }

}
