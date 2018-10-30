//
//  Home.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 29/09/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class Home: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var collectionBanner: UIImageView!
    
    @IBOutlet weak var newsCardViewHeight: NSLayoutConstraint!
    @IBOutlet weak var newsCardView: CardView!
    @IBOutlet weak var newsCornerView: UIView!
    @IBOutlet weak var scrollNewsButton: UIButton!
    
    @IBOutlet weak var buttonCornerView: UIView!
    
    @IBOutlet weak var emailCornerView: UIView!
    @IBOutlet weak var emailButton: UIButton!
    
    @IBOutlet weak var projectCornerView: UIView!
    @IBOutlet weak var projectButton: UIButton!
    
    @IBOutlet weak var unreadPostCount: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerC: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var selectedSchool: [SchoolInformation] = []
    //Quick Help arrays, used for the home page
    let iconArray: [UIImage] = [UIImage(named: "info")!, UIImage(named: "folder")!, UIImage(named: "mail")!, UIImage(named: "share-1")!, UIImage(named: "star")!]
    let titleArray: [String] = ["News", "Projects", "Feedback", "Share", "Credits"]
    let bgColorArray: [String] = ["#ccffffff", "#ccffffff", "#ccffffff", "#ccffffff", "#ccffffff"]
    
    //News
    
    //Button Tapped Boolean
    var emailActive = true
    
    //Heights of Navigation and tabBar sizes
    var topBar: CGFloat = 0
    var bottomBar: CGFloat = 0
    
    var isScrolled: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        if let data = UserDefaults.standard.value(forKey:"selectedSchool") as? Data {
            selectedSchool = try! PropertyListDecoder().decode(Array<SchoolInformation>.self, from: data)
            let selectedSchoolIndex = UserDefaults.standard.integer(forKey: "selectedSchoolIndex")
            Variables.appName = self.selectedSchool[selectedSchoolIndex].abbrName
            Variables.schoolName = self.selectedSchool[selectedSchoolIndex].abbrName
            Variables.fullSchoolName = self.selectedSchool[selectedSchoolIndex].fullName
            Variables.schoolCity = self.selectedSchool[selectedSchoolIndex].schoolCity
            
            if UserDefaults.standard.object(forKey: "schoolBanner") != nil{
                print("Image already exists")
                let savedSchoolBanner = UIImage(data: UserDefaults.standard.object(forKey: "schoolBanner") as! Data)
                Variables.schoolBanner = savedSchoolBanner
                collectionBanner.image = savedSchoolBanner
            }
            else{
                print("Downloading image")
                downloadImage(from: URL(string: self.selectedSchool[selectedSchoolIndex].schoolBanner)!)
            }
        }
        
        animateTableView(tableView: tableView, animationDuration: 1)
        animateCollectionView(collectionView: collectionView)
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
    
    //Download image asynchonously
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    //Download images
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            
            DispatchQueue.main.async() {
                Variables.schoolBanner = UIImage(data: data)
                self.collectionBanner.image = UIImage(data: data)
                UserDefaults().set(data, forKey: "schoolBanner")
            }
        }
    }
    
    //Organisation of Scrolling View
    override func viewDidLayoutSubviews() {
        topBar = (self.navigationController?.navigationBar.frame.height)!
        bottomBar = (self.tabBarController?.tabBar.frame.height)!
        newsCardViewHeight.constant = self.view.frame.size.height - (topBar + bottomBar/1.6)
    }
    
    @IBAction func maximiseNewsButton(_ sender: Any)
    {
        if (!isScrolled){
            let bottomOffset = CGPoint(x: 0, y: self.scrollView.contentSize.height - newsCardViewHeight.constant - 12)
            self.scrollView.setContentOffset(bottomOffset, animated: true)
            let img = UIImage(named: "minimize-2")
            scrollNewsButton.setImage(img , for: .normal)
            isScrolled = true
        }
        else{
            let topOffset = CGPoint(x: 0, y:0)
            self.scrollView.setContentOffset(topOffset, animated: true)
            let img = UIImage(named: "maximize-2")
            scrollNewsButton.setImage(img , for: .normal)
            isScrolled = false
        }
    }
    
    //------Set up of Quick Help Collection View------//
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "quickHelpCell", for: indexPath) as! QuickHelp
        
        cell.displayContent(icon: iconArray[indexPath.row], title: titleArray[indexPath.row], color: bgColorArray[indexPath.row])
        
        return cell
    
    }
    
    //------Set up of News Table View------//
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (emailActive){
            let cell = tableView.dequeueReusableCell(withIdentifier: "emailCell") as! EmailNewsCell
            cell.displayContent(sender: "Schola Europaea", title: "New Marking Scheme Official", description: "We are happy to announce that the new marking scheme will take place, starting this September 2018!", date: "09/08", postRead: false, cardColour: "#ffffff")
            
            if (true){ //Replace with postReadArray[indexPath.row]
                //cell.Title.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
                //cardColour = #f9f9f9
                //TODO: Create a programmatic constraint
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell") as! ProjectNewsCell
            cell.displayContent(sender: "Schola Europaea", banner: Variables.schoolBanner!, title: "Springfest 2019", description: "The new Springfest project is truly a new project that the school will love. Although our experienced organiser Mr Blomme has retired, we're certain that we're going to be able to show the school how amazing Springfest is, once again. We're certain we'll do a good job this year ;)!", date: "13/10", postRead: false, cardColour: "#ffffff")
            
            return cell
        }
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
            animateTableView(tableView: tableView, animationDuration: 0.5)
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
            animateTableView(tableView: tableView, animationDuration: 0.5)
            tableView.reloadData()
        }
    }
    
    func animateTableView(tableView:UITableView, animationDuration: Double) {
        let view = tableView
        let offset = CGPoint(x: 0, y: 200)
        var startTransform = CATransform3DIdentity // 2
        startTransform = CATransform3DRotate(CATransform3DIdentity,
                                             0, 0.0, 0.0, 1.0) // 3
        startTransform = CATransform3DTranslate(startTransform, offset.x, offset.y, 0.0) // 4
        
        // 5
        view.layer.transform = startTransform
        view.layer.opacity = 0.2
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: [.allowUserInteraction, .curveEaseInOut], animations: { () -> Void in
            view.layer.transform = CATransform3DIdentity
            view.layer.opacity = 1
        }, completion: nil)
    }
    
    func animateCollectionView(collectionView:UICollectionView) {
        let view = collectionView
        let offset = CGPoint(x: 100, y: 0)
        var startTransform = CATransform3DIdentity // 2
        startTransform = CATransform3DRotate(CATransform3DIdentity,
                                             0, 0.0, 0.0, 1.0) // 3
        startTransform = CATransform3DTranslate(startTransform, offset.x, offset.y, 0.0) // 4
        
        // 5
        view.layer.transform = startTransform
        view.layer.opacity = 0.2
        
        UIView.animate(withDuration: 1, delay: 0, options: [.allowUserInteraction, .curveEaseInOut], animations: { () -> Void in
            view.layer.transform = CATransform3DIdentity
            view.layer.opacity = 1
        }, completion: nil)
    }
}
