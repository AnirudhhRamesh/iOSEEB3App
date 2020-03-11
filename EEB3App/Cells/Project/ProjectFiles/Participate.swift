//
//  Participate.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 31/12/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class Participate: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var myTableView: UITableView!
    
    var ProjectPages: [ProjectPage] = []
    
    var Banners:[Banner] = []
    var TextCards:[TextCard] = []
    var SocialIcons:[SocialIcon] = []
    var Buttons:[Button] = []
    var Websites:[Website] = []
    var Youtubes:[Youtube] = []
    
    var totalOverviewItems:Int = 0
    var currentPosition:Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        let selectedProject = UserDefaults.standard.string(forKey: "selectedProject")
        let projectRef = Database.database().reference().child("Schools").child(Variables.schoolName).child("Projects").child(selectedProject!)
        projectRef.observe(.value, with: { snapshot in
            for page in snapshot.children {
                
                if let pageSnapshot = page as? DataSnapshot{
                    for pageItem in pageSnapshot.children{
                        //Overview page
                        if pageSnapshot.key == "Participate"{
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
                                    //let itemDictionary = itemSnapshot.value as? NSDictionary
                                    //self.SocialIcons.append(SocialIcon(pos: itemDictionary?.value(forKey: "pos") as! Int, link1: itemDictionary?.value(forKey: "link1") as! String, link2: itemDictionary?.value(forKey: "link2") as! String, link3: itemDictionary?.value(forKey: "link3") as! String, link4: itemDictionary?.value(forKey: "link4") as! String, type: itemDictionary?.value(forKey: "type") as! String))
                                    //self.SocialIcons.sorted(by: { $0.pos > $1.pos })
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
                                
                            }
                        }
                    }
                    self.totalOverviewItems = self.Banners.count + self.TextCards.count + self.SocialIcons.count + self.Buttons.count + self.Websites.count + self.Youtubes.count
                    
                    self.ProjectPages = [ProjectPage(Banners: self.Banners.sorted(by: { $0.pos > $1.pos }), TextCards: self.TextCards.sorted(by: { $0.pos > $1.pos }), SocialIcons: self.SocialIcons.sorted(by: { $0.pos > $1.pos }), Buttons: self.Buttons.sorted(by: { $0.pos > $1.pos }), Websites: self.Websites.sorted(by: { $0.pos > $1.pos }), Youtubes: self.Youtubes.sorted(by: { $0.pos > $1.pos }))]
                    print(self.ProjectPages)
                    print(self.totalOverviewItems)
                    self.myTableView.reloadData()
                }
                
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalOverviewItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Return cell based on the "pos" value from Firebase
        let bannerCell = tableView.dequeueReusableCell(withIdentifier: "BannerCell") as! BannerCell
        let textCardCell = tableView.dequeueReusableCell(withIdentifier: "TextCardCell") as! TextCardCell
        let socialIconsCell = tableView.dequeueReusableCell(withIdentifier: "SocialIconsCell") as! SocialIconsCell
        let buttonCell = tableView.dequeueReusableCell(withIdentifier: "ButtonCell") as! ButtonCell
        let websiteCell = tableView.dequeueReusableCell(withIdentifier: "WebsiteCell") as! WebViewCell
        let youtubeCell = tableView.dequeueReusableCell(withIdentifier: "YoutubeCell") as! YoutubeCell
        
        //Create an int X which is sum of all the items in ProjectPage[0].all arrays
        //Then, if let indexPath.row == X, query through ProjectPages and retrieve the item I that has pos X.
        //If I belongs to Banners, return BannerCell: if Banners.contains(I){return bannerCell}, else if TextCards.contains...
        
        if indexPath.row <= totalOverviewItems{
            print(indexPath.row)
            for textCard in ProjectPages[0].TextCards{
                if textCard.pos == indexPath.row{
                    print("TextCard cell: Position = \(indexPath.row)")
                    textCardCell.displayContent(title: textCard.title, text: textCard.text)
                    return textCardCell
                }
            }
            for item in ProjectPages[0].Banners{
                if item.pos == indexPath.row{
                    print("Banner cell: Position = \(indexPath.row)")
                    bannerCell.displayContent(banner: UIImage(named: "EEB3Banner")!, title: item.title, description: item.description, text: item.text)
                    return bannerCell
                }
            }
            
            for socialIcon in ProjectPages[0].SocialIcons{
                if socialIcon.pos == indexPath.row{
                    socialIconsCell.displayContent(title1: socialIcon.link1, title2: socialIcon.link2, title3: socialIcon.link3, title4: socialIcon.link4)
                    return socialIconsCell
                }
            }
            for button in ProjectPages[0].Buttons{
                if button.pos == indexPath.row{
                    //Set link of buttonCell
                    buttonCell.displayContent(title: button.title)
                    return buttonCell
                }
            }
            for website in ProjectPages[0].Websites{
                if website.pos == indexPath.row{
                    //Set link of websiteCell
                    return websiteCell
                }
            }
            for youtube in ProjectPages[0].Youtubes{
                if youtube.pos == indexPath.row{
                    //Set link of youtubeCell
                    return youtubeCell
                }
            }
        }
        return textCardCell
    }
    
}
