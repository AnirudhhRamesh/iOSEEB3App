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
    var Banners:[Banner]
    var TextCards:[TextCard]
    var SocialIcons:[SocialIcon]
    var Buttons:[Button]
    var Websites:[Website]
    var Youtubes:[Youtube]
}

struct Banner:Codable{
    var pos:Int
    //var page:String --> We would use this to collect everything in one project page... This is probably not ideal but it would work.
    var image:String
    var title:String
    var description:String
    var text:String
}

struct TextCard:Codable{
    var pos:Int
    var title:String
    var text:String
}

struct SocialIcon:Codable{
    var pos:Int
    var link1:String
    var link2:String
    var link3:String
    var link4:String
    var type:String
}

struct Button:Codable{
    var pos:Int
    var title:String
    var link:String
}

struct Website:Codable{
    var pos:Int
    var link:String
}

struct Youtube:Codable{
    var pos:Int
    var link:String
}

class Overview: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var myTableView: UITableView!
    
    var ProjectPages: [ProjectPage] = []

    var Banners:[Banner] = []
    var TextCards:[TextCard] = []
    var SocialIcons:[SocialIcon] = []
    var Buttons:[Button] = []
    var Websites:[Website] = []
    var Youtubes:[Youtube] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        print("Loaded Overview Page")
        
        let selectedProject = UserDefaults.standard.string(forKey: "selectedProject")
        let projectRef = Database.database().reference().child("Schools").child(Variables.schoolName).child("Projects").child(selectedProject!)
        projectRef.observe(.value, with: { snapshot in
            for page in snapshot.children {
                
                if let pageSnapshot = page as? DataSnapshot{
                    for pageItem in pageSnapshot.children{
                        //Overview page
                        if pageSnapshot.key == "Overview"{
                            if let itemSnapshot = pageItem as? DataSnapshot{
                                //Banners
                                if itemSnapshot.key.range(of: "Banner") != nil{
                                    let itemDictionary = itemSnapshot.value as? NSDictionary
                                    self.Banners.append(Banner(pos: itemDictionary?.value(forKey: "pos") as! Int, image: itemDictionary?.value(forKey: "image") as! String, title: itemDictionary?.value(forKey: "title") as! String, description: itemDictionary?.value(forKey: "description") as! String, text: itemDictionary?.value(forKey: "text") as! String))
                                }
                                //TextCards
                                if itemSnapshot.key.range(of: "TextCard") != nil{
                                    let itemDictionary = itemSnapshot.value as? NSDictionary
                                    self.TextCards.append(TextCard(pos: itemDictionary?.value(forKey: "pos") as! Int, title: itemDictionary?.value(forKey: "title") as! String, text: itemDictionary?.value(forKey: "text") as! String))
                                }
                                //SocialIcons
                                if itemSnapshot.key.range(of: "SocialIcons") != nil{
                                    let itemDictionary = itemSnapshot.value as? NSDictionary
                                    //self.SocialIcons.append(SocialIcon(pos: itemDictionary?.value(forKey: "pos") as! Int, link1: itemDictionary?.value(forKey: "link1") as! String, link2: itemDictionary?.value(forKey: "link2") as! String, link3: itemDictionary?.value(forKey: "link3") as! String, link4: itemDictionary?.value(forKey: "link4") as! String, type: itemDictionary?.value(forKey: "type") as! String))
                                }
                                //Button
                                if itemSnapshot.key.range(of: "Button") != nil{
                                    let itemDictionary = itemSnapshot.value as? NSDictionary
                                    self.Buttons.append(Button(pos: itemDictionary?.value(forKey: "pos") as! Int, title: itemDictionary?.value(forKey: "title") as! String, link: itemDictionary?.value(forKey: "link") as! String))
                                }
                                //Website
                                if itemSnapshot.key.range(of: "Website") != nil{
                                    let itemDictionary = itemSnapshot.value as? NSDictionary
                                    self.Websites.append(Website(pos: itemDictionary?.value(forKey: "pos") as! Int, link: itemDictionary?.value(forKey: "link") as! String))
                                }
                                //Youtube
                                if itemSnapshot.key.range(of: "Youtube") != nil{
                                    let itemDictionary = itemSnapshot.value as? NSDictionary
                                    self.Youtubes.append(Youtube(pos: itemDictionary?.value(forKey: "pos") as! Int, link: itemDictionary?.value(forKey: "link") as! String))
                                }
                                
                                self.ProjectPages.append(ProjectPage(Banners: self.Banners, TextCards: self.TextCards, SocialIcons: self.SocialIcons, Buttons: self.Buttons, Websites: self.Websites, Youtubes: self.Youtubes))
                                print(self.ProjectPages)
                                self.myTableView.reloadData()
                            }
                        }
                    }
                }
                
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProjectPages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Return cell based on the "pos" value from Firebase
        var bannerCell = tableView.dequeueReusableCell(withIdentifier: "BannerCell") as! BannerCell
        var textCardCell = tableView.dequeueReusableCell(withIdentifier: "TextCardCell") as! TextCardCell
        var socialIconsCell = tableView.dequeueReusableCell(withIdentifier: "SocialIconsCell") as! SocialIconsCell
        var buttonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! ButtonCell
        var websiteCell = tableView.dequeueReusableCell(withIdentifier: "WebsiteCell") as! WebViewCell
        var youtubeCell = tableView.dequeueReusableCell(withIdentifier: "YoutubeCell") as! YoutubeCell
        
        for itemType in ProjectPages[0].Banners{
            print(itemType)
            if let item = itemType as? NSDictionary{
                print("item: \(item)")
            }
        }
        
        bannerCell.displayContent(banner: UIImage(named: "EEB3Banner")!, title: "Springfest 2019", description: "School Event", text: "Last update 01.01.2019")
        
        return bannerCell
    }
    
}
