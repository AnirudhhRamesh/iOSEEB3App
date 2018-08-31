//
//  ThirdViewController.swift
//  EEB3App
//
//  Created by RAMESH anirudhh on 08/08/17.
//  Copyright © 2017 RAMESH anirudhh. All rights reserved.
//

import UIKit
import Social
import FirebaseDatabase
import SystemConfiguration

var NotificationTitles: [String] = []
var NotificationDescriptions: [String] = []
var NotificationDates: [String] = []
var NotificationSenders: [String] = []

var NotifIndex: Int = 0

class HomeView: UIViewController, UITableViewDelegate, UITableViewDataSource{

    var time = Timer()
    
    var handle: DatabaseHandle?
    var ref: DatabaseReference?
    var x: Int = 0
    
    //List of String Array variables to hold notification variables
    

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var timeText: UILabel!
    @IBOutlet weak var dateText: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(HomeView.DateandTime), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if isInternetAvailable(){
        NotificationTitles = []
        NotificationDescriptions = []
        NotificationDates = []
        NotificationSenders = []

        ref = Database.database().reference()
        handle = ref?.child("Notifications").observe(.childAdded, with: { (snapshot) in
            
            var numberOfChildren = 0
            for child in (snapshot.children) {
                
                numberOfChildren = numberOfChildren + 1
                print(numberOfChildren)
                
                let snap = child as! DataSnapshot
                
                if let item = snap.value as? String
                {
                    let itemKey = snap.key
                    print(itemKey)
                    if itemKey.range(of: "title") != nil
                    {
                        NotificationTitles.append(item)
                    }
                    if itemKey.range(of: "text") != nil
                    {
                        NotificationDescriptions.append(item)
                        
                    }
                    else if itemKey.range(of: "date") != nil
                    {
                        NotificationDates.append(item)
                        
                    }
                    else if itemKey.range(of: "sender") != nil
                    {
                        NotificationSenders.append(item)
                    }
                }
            }
            //self.UpdateProjectsArray()
            self.myTableView.reloadData()
        })
        }
        else{
            if x == 0{
            let alertsocial = UIAlertController(title: "No internet connection", message: "You aren't connected to the internet", preferredStyle: .alert)
            let actionsocial = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
            
            alertsocial.addAction(actionsocial)
            self.present(alertsocial, animated: true, completion: nil)
            x = 1
        }
        }
    }

    func DateandTime() {
        
        let time = DateFormatter()
        let date = DateFormatter()
        
        time.timeStyle = .short
        date.dateStyle = .medium
        
        timeText.text = time.string(from: Date())
        dateText.text = date.string(from: Date())
    }
    
    @IBAction func shareButtonDialog(_ sender: Any)
    {
        
        let text = "Still haven't downloaded the EEB3 App for iOS devices? Why not download it now, off the following link: Bit.ly/EEB3iOS!"
        
        // set up activity view controller
        let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    func showAlert(service: String)
    {
        let alertsocial = UIAlertController(title: "Error", message: "You are not connected to \(service)", preferredStyle: .alert)
        let actionsocial = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        
        alertsocial.addAction(actionsocial)
        present(alertsocial, animated: true, completion: nil)
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return NotificationTitles.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NotificationCell
        
        cell.myNotificationTitle.text = NotificationTitles[indexPath.row]
        cell.myNotificationDescription.text = NotificationDescriptions[indexPath.row]
        cell.myNotificationDate.text = NotificationDates[indexPath.row]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        NotifIndex = indexPath.row
        
        print("zebra \(indexPath.row)")
        
        if let cell = tableView.cellForRow(at: indexPath) as? NotificationCell {
        
        cell.myNotificationCardView.backgroundColor = hexStringToUIColor(hex: "#f5f5f5")
        
        cell.myNotificationTitle.font = UIFont(name:"HelveticaNeue", size: 15.0)
        cell.myNotificationTitle.textColor = UIColor.darkGray
        
        cell.myNotificationDate.font = UIFont(name:"HelveticaNeue", size: 13.0)
        cell.myNotificationDate.textColor = UIColor.darkGray

        cell.myNotificationDescription.textColor = UIColor.darkGray
        
        performSegue(withIdentifier: "detailNotifSegue", sender: self)
        }
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

    
    //ProjectTitles.count + 1
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
}
