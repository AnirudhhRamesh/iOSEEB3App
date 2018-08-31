//
//  DetailNotificationView.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 03/04/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import UIKit


class DetailNotificationView: UIViewController{
    
    @IBOutlet weak var notifTitle: UILabel!
    
    @IBOutlet weak var notifDate: UILabel!
    
    @IBOutlet weak var notifText: UILabel!
    
    @IBOutlet weak var notifSender: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notifTitle.text = NotificationTitles[NotifIndex]
        
        notifDate.text = NotificationDates[NotifIndex]
        
        notifText.text = NotificationDescriptions[NotifIndex]
        
        notifSender.text = "Sent by " + NotificationSenders[NotifIndex]
    }
    
}
