//
//  Websites.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 02/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct WebsiteStruct{
    var title: String
    var description: String
    var banner: String
    var link: String
}

var siteInfos: [WebsiteStruct] = []
var siteSections: [String] = []

class Websites: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let websitesRef = Database.database().reference().child("Schools").child(Variables.schoolName).child("Websites")
        
        websitesRef.observe(.value, with: { snapshot in
            for site in snapshot.children {
                if let siteSnapshot = site as? DataSnapshot{
                    let siteInfo = siteSnapshot.value as? NSDictionary
                    siteInfos.append(WebsiteStruct(title: siteInfo?.value(forKey: "title") as! String, description: siteInfo?.value(forKey: "description") as! String, banner: siteInfo?.value(forKey: "banner") as! String, link: siteInfo?.value(forKey: "link") as! String))
                }
            }
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        for website in siteInfos{
            let section = website.description
            if !siteSections.contains(section){
                siteSections.append(section)
            }
        }
        return siteSections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "websiteSectionCell") as! WebsiteSectionCell
        cell.displayContent(sectionTitle: siteSections[indexPath.row], indexPath: indexPath.row)
        return cell
    }
}
