//
//  Projects.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 02/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class Projects: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var cornerViewProjects: UIView!
    @IBOutlet weak var cornerViewProjectsNews: UIView!
    @IBOutlet weak var ProjectNewsCardHeight: NSLayoutConstraint!
    
    @IBOutlet weak var scrollButton: UIButton!
    
    //Heights of Navigation and tabBar sizes
    var topBar: CGFloat = 0
    var bottomBar: CGFloat = 0
    var isScrolled:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        cornerViewProjects.layer.cornerRadius = 15
        cornerViewProjects.layer.masksToBounds = true
        
        cornerViewProjectsNews.layer.cornerRadius = 15
        cornerViewProjectsNews.layer.masksToBounds = true
        
    }
    
    //Organisation of Scrolling View
    override func viewDidLayoutSubviews() {
        topBar = (self.navigationController?.navigationBar.frame.height)!
        bottomBar = (self.tabBarController?.tabBar.frame.height)!
        ProjectNewsCardHeight.constant = self.view.frame.size.height - (topBar + bottomBar/1.6)
    }
    
    @IBAction func scrollButtonTapped(_ sender: Any)
    {
        if (!isScrolled){
            let bottomOffset = CGPoint(x: 0, y: self.scrollView.contentSize.height - ProjectNewsCardHeight.constant - 12)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            let img = UIImage(named: "minimize-2")
            scrollButton.setImage(img , for: .normal)
            isScrolled = true
        }
        else{
            let topOffset = CGPoint(x: 0, y:0)
            self.scrollView.setContentOffset(topOffset, animated: true)
            let img = UIImage(named: "maximize-2")
            scrollButton.setImage(img , for: .normal)
            isScrolled = false
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "projectCell", for: indexPath) as! ProjectIconCell
        
        cell.displayContent(banner: UIImage(named: "Desert")!, title: "Springfest 2019", projectDescription: "School event", color: "#3f51b5")
        
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        
        return cell
    }
    
    func tap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: location)
        
        if let index = indexPath {
            print("Got clicked on index: \(index)!")
        }
    }
    
    @IBAction func fullProjectView(_ sender: Any)
    {
        performSegue(withIdentifier: "projectFullView", sender: self)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell2") as! ProjectNewsCell
            
            cell.displayContent(sender: "Schola Europa", banner: Variables.schoolBanner!, title: "Student Courses", description: "This is the text that would be used to identify the Student Courses description", date: "20/11", postRead: true, cardColour: "#ffffff")
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell2") as! ProjectNewsCell
            
            cell.displayContent(sender: "Schola Europa", banner: Variables.schoolBanner!, title: "Springfest 2018", description: "We have a feedback form, where we want to know more about the positive and negative aspects about SF 2018", date: "19/06", postRead: false, cardColour: "#ffffff")
            
            return cell
        }
    }
    
    
    
}
