//
//  Schedule.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 20/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

struct ScheduleClass:Codable{
    var cellCoordinate: [Int] = [0]
    var title: String = ""
    var room: String = ""
    var colour: String = ""
}

@available(iOS 11.0, *)
class Schedule: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Heights of Navigation and tabBar sizes
    var topBar: CGFloat = 0
    var bottomBar: CGFloat = 0
    var testIndexPath: IndexPath = IndexPath(row: 0, section: 0)
    var count: Int = 0
    
    var Courses: [ScheduleClass] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        count = 0
        collectionView?.collectionViewLayout = columnLayout
        collectionView?.contentInsetAdjustmentBehavior = .always
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let data = UserDefaults.standard.value(forKey:"courses") as? Data {
            Courses = try! PropertyListDecoder().decode(Array<ScheduleClass>.self, from: data)
            //Code to iterate through Courses
            for i in self.Courses{
                while count < i.cellCoordinate.count{
                    let cell = self.collectionView.cellForItem(at: IndexPath(row: i.cellCoordinate[count], section: 0)) as! PeriodCollectionViewCell
                    print(i)
                    cell.courseTitle.text = i.title
                    cell.coursePeriod.text = i.room
                    cell.courseBackground.backgroundColor = UIColor(hexString: i.colour)
                    //Setting text color to white
                    cell.courseTitle.textColor = UIColor.white
                    cell.courseTitle.font = UIFont(name: "Avenir-Heavy", size: 17)
                    cell.courseRoom.textColor = UIColor.white
                    cell.coursePeriod.textColor = UIColor.white

                    print(count)
                    count = count + 1
                }
                count = 0
            }
        }
    }
    
    override func viewLayoutMarginsDidChange() {
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation){
            topBar = (self.navigationController?.navigationBar.frame.height)!
            bottomBar = (self.tabBarController?.tabBar.frame.height)!
            let screenCorrectedHeight = self.view.frame.height - 6.55*(topBar + bottomBar)
            
            screenHeight = screenCorrectedHeight
            
            print(self.view.frame.height)
            print(screenCorrectedHeight)
            print(self.collectionView.frame.height)
        }
        else{
            topBar = (self.navigationController?.navigationBar.frame.height)!
            bottomBar = (self.tabBarController?.tabBar.frame.height)!
            var screenCorrectedHeight: CGFloat = 0
            if self.view.frame.height >= 800{
                screenCorrectedHeight = self.view.frame.height - 3.4*(topBar + bottomBar)
            }
            else{
                screenCorrectedHeight = self.view.frame.height - 3*(topBar + bottomBar)
            }
            screenHeight = screenCorrectedHeight
            
            print(self.view.frame.height)
            print(screenCorrectedHeight)
            print(self.collectionView.frame.height)
        }
    }
    
    let columnLayout = ColumnFlowLayout(
        cellsPerRow: 5,
        minimumInteritemSpacing: 0,
        minimumLineSpacing: 0,
        sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    )
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "period", for: indexPath) as! PeriodCollectionViewCell
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        //Breaks
        if indexPath.row >= 15 && indexPath.row <= 19{
            cell.displayContent(title: "Break", period: "15 Mins", room: "", bgColour: "#EFEFF4")
            cell.courseTitle.textColor = UIColor(hexString: "#555555")
            cell.courseTitle.font = UIFont(name: "Avenir-Book", size: 17)
            cell.coursePeriod.textColor = UIColor(hexString: "#AAAAAA")
            cell.courseBackground.shadowOpacity = 0
        }
        else if indexPath.row != 32 && indexPath.row >= 30 && indexPath.row <= 34{
            cell.displayContent(title: "Break", period: "55 Mins", room: "", bgColour: "#EFEFF4")
            cell.courseTitle.textColor = UIColor(hexString: "#555555")
            cell.courseTitle.font = UIFont(name: "Avenir-Book", size: 17)
            cell.coursePeriod.textColor = UIColor(hexString: "#AAAAAA")
            cell.courseBackground.shadowOpacity = 0
        }
        else if indexPath.row == 32 || indexPath.row == 37 || indexPath.row == 42 || indexPath.row == 47{
            cell.displayContent(title: "", period: "", room: "", bgColour: "#EFEFF4")
            cell.courseTitle.textColor = UIColor(hexString: "#555555")
            cell.courseTitle.font = UIFont(name: "Avenir-Book", size: 17)
            cell.coursePeriod.textColor = UIColor(hexString: "#AAAAAA")
            cell.courseBackground.shadowOpacity = 0
        }
            //Period 1
        else if indexPath.row >= 0 && indexPath.row <= 4{
            cell.displayContent(title: "Free", period: "P1", room: "", bgColour: "#ffffff")
        }
            //Period 2
        else if indexPath.row >= 5 && indexPath.row <= 9{
            cell.displayContent(title: "Free", period: "P2", room: "", bgColour: "#ffffff")
        }
            //Period 3
        else if indexPath.row >= 10 && indexPath.row <= 14{
            cell.displayContent(title: "Free", period: "P3", room: "", bgColour: "#ffffff")
        }
            //Period 4
        else if indexPath.row >= 20 && indexPath.row <= 24{
            cell.displayContent(title: "Free", period: "P4", room: "", bgColour: "#ffffff")
        }
            //Period 5
        else if indexPath.row >= 25 && indexPath.row <= 29{
            cell.displayContent(title: "Free", period: "P5", room: "", bgColour: "#ffffff")
        }
            //Period 7
        else if indexPath.row >= 35 && indexPath.row <= 39{
            cell.displayContent(title: "Free", period: "P7", room: "", bgColour: "#ffffff")
        }
            //Period 8
        else if indexPath.row >= 40 && indexPath.row <= 44{
            cell.displayContent(title: "Free", period: "P8", room: "", bgColour: "#ffffff")
        }
            //Period 9
        else if indexPath.row >= 45 && indexPath.row <= 49{
            cell.displayContent(title: "Free", period: "P9", room: "", bgColour: "#ffffff")
        }
            //Error
        else{
            cell.displayContent(title: "Error", period: "", room: "----", bgColour: "#ffffff")
        }
        return cell
    }
    
    
    func tap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: location)
        print("indexPath of the cell tapped is \(indexPath)")
    }
}
