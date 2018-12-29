//
//  Projects.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 02/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct ProjectOverviewStruct:Codable{
    var title:String
    var type: String
    var banner:String
    var colour: String
    var lastUpdated: String
}
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
    
    var selectedSchool: [SchoolInformation] = []
    var ProjectInformation: [ProjectOverviewStruct] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        cornerViewProjects.layer.cornerRadius = 15
        cornerViewProjects.layer.masksToBounds = true
        
        cornerViewProjectsNews.layer.cornerRadius = 15
        cornerViewProjectsNews.layer.masksToBounds = true
        
        if let data = UserDefaults.standard.value(forKey:"selectedSchool") as? Data {
            selectedSchool = try! PropertyListDecoder().decode(Array<SchoolInformation>.self, from: data)
            let selectedSchoolIndex = UserDefaults.standard.integer(forKey: "selectedSchoolIndex")
            
            //Get the list of projects and display them in the project collectionView
            let projectsRef = Database.database().reference().child("Schools").child(Variables.schoolName).child("Projects")
            projectsRef.observe(.value, with: { snapshot in
                for project in snapshot.children {
                    if let projectSnapshot = project as? DataSnapshot{
                        let otherProjectInformation = projectSnapshot.childSnapshot(forPath: "Other").value as? NSDictionary
                        self.ProjectInformation.append(ProjectOverviewStruct(title: otherProjectInformation?.value(forKey: "title") as! String, type: otherProjectInformation?.value(forKey: "type") as! String, banner: otherProjectInformation?.value(forKey: "banner") as! String, colour: otherProjectInformation?.value(forKey: "colour") as! String, lastUpdated: otherProjectInformation?.value(forKey: "lastUpdated") as! String))
                        print(self.ProjectInformation)
                        self.collectionView.reloadData()
                    }
                }
            })
            
            /*
            if UserDefaults.standard.object(forKey: "schoolBanner") != nil{
                print("Image already exists")
                let savedSchoolBanner = UIImage(data: UserDefaults.standard.object(forKey: "schoolBanner") as! Data)
                Variables.schoolBanner = savedSchoolBanner
            }
            else{
                print("Downloading image")
            }
            */
            
        }
    }
    
    //Download image asynchonously
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL, indexPath: IndexPath) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            
            DispatchQueue.main.async() {
                Variables.schoolBanner = UIImage(data: data)
                //self.collectionBanner.image = UIImage(data: data)
                UserDefaults().set(data, forKey: self.ProjectInformation[indexPath.row].title)
            }
        }
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
        return ProjectInformation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Sort out cells by the date they were last updated here:
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "projectCell", for: indexPath) as! ProjectIconCell
        //Add in the banners later on
        cell.displayContent(banner: UIImage(named: "Desert")!, title: ProjectInformation[indexPath.row].title, projectDescription: ProjectInformation[indexPath.row].type)
        
        print(ProjectInformation[indexPath.row].title)
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        
        return cell
    }
    
    func tap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: location)
        
        if let index = indexPath {
            print("Got clicked on index: \(index)!")
            //performSegue
            UserDefaults.standard.set(ProjectInformation[index.row].title, forKey: "selectedProject")
            //Open the selected project view, by setting the project values
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
