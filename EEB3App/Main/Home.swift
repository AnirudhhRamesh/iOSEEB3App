//
//  Home.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 29/09/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class Home: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cornerView: UIView!
    
    @IBOutlet weak var newsCornerView: UIView!
    
    @IBOutlet weak var buttonCornerView: UIView!
    
    @IBOutlet weak var emailCornerView: UIView!
    @IBOutlet weak var emailButton: UIButton!
    
    @IBOutlet weak var projectCornerView: UIView!
    @IBOutlet weak var projectButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerC: UIView!
    
    //Quick Help arrays, used for the home page
    let iconArray: [UIImage] = [UIImage(named: "info")!, UIImage(named: "folder")!, UIImage(named: "mail")!, UIImage(named: "share-1")!, UIImage(named: "star")!]
    let titleArray: [String] = ["News", "Projects", "Feedback", "Share", "Credits"]
    let bgColorArray: [String] = ["#ccffffff", "#ccffffff", "#ccffffff", "#ccffffff", "#ccffffff"]
    
    //News
    
    //Button Tapped Boolean
    var emailActive = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        newsCornerView.layer.cornerRadius = 15
        newsCornerView.layer.masksToBounds = true
    
        cornerView.layer.cornerRadius = Variables.cornerRadius
        cornerView.layer.masksToBounds = true
        
        buttonCornerView.layer.cornerRadius = Variables.cornerRadius
        buttonCornerView.layer.masksToBounds = true
        
        emailCornerView.layer.cornerRadius = Variables.cornerRadius
        emailCornerView.layer.masksToBounds = true
        
        projectCornerView.layer.cornerRadius = Variables.cornerRadius
        projectCornerView.layer.masksToBounds = true
    }
    
    
    //------Set up of Quick Help Collection View------//
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "quickHelpCell", for: indexPath) as! QuickHelp
        
        //cell.CircularCardView.makeCircular()
        
        cell.displayContent(icon: iconArray[indexPath.row], title: titleArray[indexPath.row], color: bgColorArray[indexPath.row])
        
        return cell
    
    }
    
    //------Set up of News Table View------//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProjectNewsCell
        
        if (emailActive){
            cell.displayContent(sender: "Schola Europa", title: "Schola Europa", description: "We are happy to announce that the new marking scheme will take place, starting this September 2018!", date: "09/08", postRead: false, cardColour: "#ffffff")
            if (true){ //Replace with postReadArray[indexPath.row]
                //cell.Title.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
                //cardColour = #f9f9f9
                //TODO: Create a programmatic constraint
            }
        }
        else{
            cell.displayContent(sender: "Schola Europa", title: "Springfest 2019", description: "The new Springfest project is truly a new project that the school will love. Although our experienced organiser Mr Blomme has retired, we're certain that we're going to be able to show the school how amazing Springfest is, once again. We're certain we'll do a good job this year ;)!", date: "13/10", postRead: false, cardColour: "#ffffff")
        }
        return cell
    }
    
    
    //Button Selection
    @IBAction func emailButtonTapped(_ sender: Any)
    {
        if emailActive == false{
            emailButton.setTitleColor(UIColor.white, for: .normal)
            emailButton.backgroundColor = UIColor.init(hexString: Variables.accentColor)
            
            projectButton.setTitleColor(UIColor.lightGray, for: .normal)
            projectButton.backgroundColor = UIColor.groupTableViewBackground
            
            emailActive = true
            tableView.reloadData()
        }
    }
    
    @IBAction func projectButtonTapped(_ sender: Any)
    {
        if emailActive == true{
            projectButton.setTitleColor(UIColor.white, for: .normal)
            projectButton.backgroundColor = UIColor.init(hexString: Variables.accentColor)

            emailButton.setTitleColor(UIColor.lightGray, for: .normal)
            emailButton.backgroundColor = UIColor.groupTableViewBackground
            
            emailActive = false
            tableView.reloadData()
        }
    }
    
    
}
