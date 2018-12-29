//
//  Overview.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 29/12/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct ProjectPage:Codable{
    //Figure out how to store the values, maybe a struct per type (so struct for bannercells, struct for textcardcells), and then group them together under this ProjectPageStruct.
    //Then read sort the ProjectPageStruct based on the page (eg. Overview, Participate or More) and then sort through these page items based on the "Pos" value.
    var Banner:Banner
    var TextCard:TextCard
    var SocialIcons:SocialIcons
    var Button:Button
    var Website:Website
    var Youtube:Youtube
}

struct Banner:Codable{
    var pos:String
    //var page:String --> We would use this to collect everything in one project page... This is probably not ideal but it would work.
    var image:String
    var title:String
    var description:String
    var text:String
}

struct TextCard:Codable{
    var pos:String
    var title:String
    var text:String
}

struct SocialIcons:Codable{
    var pos:String
    var link:String
    var type:String
}

struct Button:Codable{
    var pos:String
    var title:String
    var link:String
}

struct Website:Codable{
    var pos:String
    var link:String
}

struct Youtube:Codable{
    var pos:String
    var link:String
}

class Overview: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let selectedProject = UserDefaults.standard.string(forKey: "selectedProject")
        let projectRef = Database.database().reference().child("Schools").child(Variables.schoolName).child("Projects").child(selectedProject!)
        projectRef.observe(.value, with: { snapshot in
            for page in snapshot.children {
                if let pageSnapshot = page as? DataSnapshot{
                    let pageInformation = pageSnapshot.childSnapshot(forPath: "Overview").value as? NSDictionary
                    //Save the values here
                    
                    self.ProjectInformation.append(ProjectOverviewStruct(title: otherProjectInformation?.value(forKey: "title") as! String, type: otherProjectInformation?.value(forKey: "type") as! String, banner: otherProjectInformation?.value(forKey: "banner") as! String, colour: otherProjectInformation?.value(forKey: "colour") as! String, lastUpdated: otherProjectInformation?.value(forKey: "lastUpdated") as! String))
                    print(self.ProjectInformation)
                    self.collectionView.reloadData()
                }
            }
        })
        
        
        if let data = UserDefaults.standard.value(forKey:"selectedSchool") as? Data {
            selectedSchool = try! PropertyListDecoder().decode(Array<SchoolInformation>.self, from: data)
            let selectedSchoolIndex = UserDefaults.standard.integer(forKey: "selectedSchoolIndex")
            
            //Get the list of projects and display them in the project collectionView
            
            
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Return cell based on the "pos" value from Firebase
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        return cell
    }
    
}
