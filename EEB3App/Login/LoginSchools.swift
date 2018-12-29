//
//  LoginSchools.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 29/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct SchoolInformation:Codable{
    var abbrName: String
    var fullName: String
    var schoolCity:String
    var schoolBanner:String
}

class LoginSchools: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    
    var schoolInformation: [SchoolInformation] = []
    var schoolLocations: [String] = []
    var count:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let schoolsRef = Database.database().reference().child("Schools")
        schoolsRef.observe(.value, with: { snapshot in
            for school in snapshot.children {
                if let schoolSnapshot = school as? DataSnapshot{
                    let generalSchoolInformation = schoolSnapshot.childSnapshot(forPath: "General Information").value as? NSDictionary
                    self.schoolInformation.append(SchoolInformation(abbrName: generalSchoolInformation?.value(forKey: "abbrName") as! String, fullName: generalSchoolInformation?.value(forKey: "fullName") as! String, schoolCity: generalSchoolInformation?.value(forKey: "schoolCity") as! String, schoolBanner: generalSchoolInformation?.value(forKey: "schoolBanner") as! String))
                    print(self.schoolInformation)
                    self.tableView.reloadData()
                }
            }
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        for school in schoolInformation{
            let location = school.schoolCity
            if !schoolLocations.contains(location){
                schoolLocations.append(location)
            }
        }
        return schoolLocations.count //Create a while function that adds addresses based on locations
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        while count < schoolLocations.count{
            switch section{
            case count:
                return schoolLocations[count]
            default:
                return "Schools"
            }
        }
        return "Schools"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schoolInformation.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "schoolCell") as! LoginSchoolCell
        cell.displaySchool(schoolName: schoolInformation[indexPath.row].fullName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(schoolInformation), forKey:"selectedSchool")
        UserDefaults.standard.set(indexPath.row, forKey: "selectedSchoolIndex")
        UserDefaults.standard.set(true, forKey: "isSchoolSelected")
        performSegue(withIdentifier: "homeSegue", sender: self)
    }
    
    
}
