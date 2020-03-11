//
//  Settings.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 13/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

struct SettingsStruct {
    var cellType: [Int] = []
    var textArray: [String] = [""]
    var switchStateArray: [Bool] = []
}

//Pass any objects, params you need to use on the
//segue call to send to the next controller.

protocol MyCustomCellDelegator {
    func callSegueFromCell(myData dataobject: IndexPath)
}

class Settings: UIViewController, UITableViewDelegate, UITableViewDataSource, MyCustomCellDelegator{
    
    var tableViewTitle: [String] = ["Account", "Design", "Notifications", "Connect", "More"]
    var tableViewIcon: [UIImage] = [UIImage(named: "info")!, UIImage(named: "info")!, UIImage(named: "info")!, UIImage(named: "info")!, UIImage(named: "info")!]

    var AccountStruct = SettingsStruct(cellType: [0,1,3], textArray: ["Rameshan@student.eursc.eu", "Change School", "Logout"], switchStateArray: [false, false, false]) //TODO: set the office365 email as the first TextArray string. Set the StateArray to the shared Preferences.
    var DesignStruct = SettingsStruct(cellType: [2], textArray: ["Dark Mode"], switchStateArray: [false])
    var NotificationsStruct = SettingsStruct(cellType: [2,2], textArray: ["Emails", "Projects"], switchStateArray: [true, true])
    var ConnectStruct = SettingsStruct(cellType: [1, 1, 1], textArray: ["Send us Feedback", "Follow our Facebook", "Rate this App"], switchStateArray: [false, false, false])
    var MoreStruct = SettingsStruct(cellType: [1,1,1], textArray: ["About", "Licenses", "Credits"], switchStateArray: [false, false, false])
    
    var SettingsStructsArray = [SettingsStruct()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SettingsStructsArray = [AccountStruct, DesignStruct, NotificationsStruct, ConnectStruct, MoreStruct]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.navigationBar.tintColor = UIColor.init(hexString: "#3f51b5")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.row)
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "quickHelp") as! QuickHelpSettings
            cell.delegate = self
            return cell
        }
        else{
            switch tableViewTitle[indexPath.row - 1]{
            case "Account":
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SettingsTable
                cell.displayContent(tableViewTitle: tableViewTitle[indexPath.row - 1], tableViewIcon: tableViewIcon[indexPath.row - 1], settingsStruct: AccountStruct)
                return cell
            case "Design":
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SettingsTable
                cell.displayContent(tableViewTitle: tableViewTitle[indexPath.row - 1], tableViewIcon: tableViewIcon[indexPath.row - 1], settingsStruct: MoreStruct)
                return cell
            case "Notifications":
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SettingsTable
                cell.displayContent(tableViewTitle: tableViewTitle[indexPath.row - 1], tableViewIcon: tableViewIcon[indexPath.row - 1], settingsStruct: ConnectStruct)
                return cell
            case "Connect":
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SettingsTable
                cell.displayContent(tableViewTitle: tableViewTitle[indexPath.row - 1], tableViewIcon: tableViewIcon[indexPath.row - 1], settingsStruct: NotificationsStruct)
                return cell
            case "More":
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SettingsTable
                cell.displayContent(tableViewTitle: tableViewTitle[indexPath.row - 1], tableViewIcon: tableViewIcon[indexPath.row - 1], settingsStruct: DesignStruct)
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SettingsTable
                cell.displayContent(tableViewTitle: "Error loading", tableViewIcon: UIImage(named: "alert-circle")!, settingsStruct: AccountStruct)
                return cell
            }
        }
        
    }
    
    //MARK: - MyCustomCellDelegator Methods
    
    func callSegueFromCell(myData dataobject: IndexPath) {
        //try not to send self, just to avoid retain cycles(depends on how you handle the code on the next controller)
        //self.performSegue(withIdentifier: "creditsSegue", sender:dataobject )
        print("Segue function is being called in Settings view")
        if dataobject.row == 2{
            self.performSegue(withIdentifier: "creditsSegue", sender: self)
        }
    }
    
}
