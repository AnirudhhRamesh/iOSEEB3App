//
//  AddPeriod.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 20/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 11.0, *)
class AddPeriod: UIViewController,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var className: UITextField!
    @IBOutlet weak var classRoom: UITextField!
    
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button12: UIButton!
    @IBOutlet weak var button13: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var savePeriod: UIButton!
    
    var Courses: [ScheduleClass] = []
    var selectedColourString: String = ""
    var selectedPeriods: [Int] = []
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.collectionViewLayout = columnLayout
        collectionView?.contentInsetAdjustmentBehavior = .always
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        button0.layer.cornerRadius = min(button0.frame.size.height, button0.frame.size.width) / 1.8
        button0.clipsToBounds = true
        button0.layer.borderColor = UIColor.black.cgColor
        button1.layer.cornerRadius = min(button0.frame.size.height, button0.frame.size.width) / 1.8
        button1.clipsToBounds = true
        button1.layer.borderColor = UIColor.black.cgColor
        button2.layer.cornerRadius = min(button0.frame.size.height, button0.frame.size.width) / 1.8
        button2.clipsToBounds = true
        button2.layer.borderColor = UIColor.black.cgColor
        button3.layer.cornerRadius = min(button0.frame.size.height, button0.frame.size.width) / 1.8
        button3.clipsToBounds = true
        button3.layer.borderColor = UIColor.black.cgColor
        button4.layer.cornerRadius = min(button0.frame.size.height, button0.frame.size.width) / 1.8
        button4.clipsToBounds = true
        button4.layer.borderColor = UIColor.black.cgColor
        button5.layer.cornerRadius = min(button0.frame.size.height, button0.frame.size.width) / 1.8
        button5.clipsToBounds = true
        button5.layer.borderColor = UIColor.black.cgColor
        button6.layer.cornerRadius = min(button0.frame.size.height, button0.frame.size.width) / 1.8
        button6.clipsToBounds = true
        button6.layer.borderColor = UIColor.black.cgColor
        button7.layer.cornerRadius = min(button0.frame.size.height, button0.frame.size.width) / 1.8
        button7.clipsToBounds = true
        button7.layer.borderColor = UIColor.black.cgColor
        button8.layer.cornerRadius = min(button0.frame.size.height, button0.frame.size.width) / 1.8
        button8.clipsToBounds = true
        button8.layer.borderColor = UIColor.black.cgColor
        button9.layer.cornerRadius = min(button0.frame.size.height, button0.frame.size.width) / 1.8
        button9.clipsToBounds = true
        button9.layer.borderColor = UIColor.black.cgColor
        button10.layer.cornerRadius = min(button0.frame.size.height, button0.frame.size.width) / 1.8
        button10.clipsToBounds = true
        button10.layer.borderColor = UIColor.black.cgColor
        button11.layer.cornerRadius = min(button0.frame.size.height, button0.frame.size.width) / 1.8
        button11.clipsToBounds = true
        button11.layer.borderColor = UIColor.black.cgColor
        button12.layer.cornerRadius = min(button0.frame.size.height, button0.frame.size.width) / 1.8
        button12.clipsToBounds = true
        button12.layer.borderColor = UIColor.black.cgColor
        button13.layer.cornerRadius = min(button0.frame.size.height, button0.frame.size.width) / 1.8
        button13.clipsToBounds = true
        button13.layer.borderColor = UIColor.lightText.cgColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let data = UserDefaults.standard.value(forKey:"courses") as? Data {
            Courses = try! PropertyListDecoder().decode(Array<ScheduleClass>.self, from: data)
            for i in self.Courses{
                while count < i.cellCoordinate.count{
                    let cell = self.collectionView.cellForItem(at: IndexPath(row: i.cellCoordinate[count], section: 0)) as! PeriodCollectionViewCell
                    cell.courseTitle.text = i.title
                    cell.coursePeriod.text = i.room
                    cell.courseBackground.backgroundColor = UIColor(hexString: i.colour)
                    //Setting text color to white
                    cell.courseTitle.textColor = UIColor.white
                    cell.courseTitle.font = UIFont(name: "Avenir-Heavy", size: 17)
                    cell.courseRoom.textColor = UIColor.white
                    cell.coursePeriod.textColor = UIColor.white
                    count = count + 1
                    print(count)
                }
                count = 0
            }
        }
    }
    
    
    //Heights of Navigation and tabBar sizes
    var topBar: CGFloat = 0
    var bottomBar: CGFloat = 0
    
    
    override func viewLayoutMarginsDidChange() {
        
        if UIDevice.current.orientation.isPortrait{
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
        
        collectionViewHeightConstraint.constant = screenHeight*10
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
            cell.displayContent(title: "Break", period: "", room: "", bgColour: "#EFEFF4")
            cell.courseTitle.textColor = UIColor(hexString: "#555555")
            cell.courseTitle.font = UIFont(name: "Avenir-Book", size: 17)
            cell.coursePeriod.textColor = UIColor(hexString: "#AAAAAA")
            cell.courseBackground.shadowOpacity = 0
        }
        else if indexPath.row != 32 && indexPath.row >= 30 && indexPath.row <= 34{
            cell.displayContent(title: "Break", period: "", room: "", bgColour: "#EFEFF4")
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
            cell.displayContent(title: "Period 1", period: "", room: "", bgColour: "#ffffff")
        }
            //Period 2
        else if indexPath.row >= 5 && indexPath.row <= 9{
            cell.displayContent(title: "Period 2", period: "", room: "", bgColour: "#ffffff")
        }
            //Period 3
        else if indexPath.row >= 10 && indexPath.row <= 14{
            cell.displayContent(title: "Period 3", period: "", room: "", bgColour: "#ffffff")
        }
            //Period 4
        else if indexPath.row >= 20 && indexPath.row <= 24{
            cell.displayContent(title: "Period 4", period: "", room: "", bgColour: "#ffffff")
        }
            //Period 5
        else if indexPath.row >= 25 && indexPath.row <= 29{
            cell.displayContent(title: "Period 5", period: "", room: "", bgColour: "#ffffff")
        }
            //Period 7
        else if indexPath.row >= 35 && indexPath.row <= 39{
            cell.displayContent(title: "Period 7", period: "", room: "", bgColour: "#ffffff")
        }
            //Period 8
        else if indexPath.row >= 40 && indexPath.row <= 44{
            cell.displayContent(title: "Period 8", period: "", room: "", bgColour: "#ffffff")
        }
            //Period 9
        else if indexPath.row >= 45 && indexPath.row <= 49{
            cell.displayContent(title: "Period 9", period: "", room: "", bgColour: "#ffffff")
        }
            //Error
        else{
            cell.displayContent(title: "Error", period: "", room: "----", bgColour: "#ffffff")
        }
        return cell
    }
    
    //Save the new course, once the savePeriod button is tapped
    @IBAction func savePeriodTapped(_ sender: Any) {
        
        Courses.append(ScheduleClass(cellCoordinate: selectedPeriods, title: className.text!, room: classRoom.text!, colour: selectedColourString))
        UserDefaults.standard.set(try? PropertyListEncoder().encode(Courses), forKey:"courses")
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: location)
        print("indexPath of the cell tapped is \(indexPath)")
        let cell = collectionView.cellForItem(at: indexPath!) as! PeriodCollectionViewCell
        cell.courseBackground.backgroundColor = UIColor(hexString: selectedColourString)
        selectedPeriods.append(indexPath!.row)
    }
    @IBAction func colour0(_ sender: Any) {
        button0.layer.borderWidth = 5.0
        selectedColourString = "#ED5564"
        
        button1.layer.borderWidth = 0.0
        button2.layer.borderWidth = 0.0
        button3.layer.borderWidth = 0.0
        button4.layer.borderWidth = 0.0
        button5.layer.borderWidth = 0.0
        button6.layer.borderWidth = 0.0
        button7.layer.borderWidth = 0.0
        button8.layer.borderWidth = 0.0
        button9.layer.borderWidth = 0.0
        button10.layer.borderWidth = 0.0
        button11.layer.borderWidth = 0.0
        button12.layer.borderWidth = 0.0
        button13.layer.borderWidth = 0.0
    }
    @IBAction func colour1(_ sender: Any) {
        button1.layer.borderWidth = 5.0
        selectedColourString = "#FCB0CC"
        
        button0.layer.borderWidth = 0.0
        button2.layer.borderWidth = 0.0
        button3.layer.borderWidth = 0.0
        button4.layer.borderWidth = 0.0
        button5.layer.borderWidth = 0.0
        button6.layer.borderWidth = 0.0
        button7.layer.borderWidth = 0.0
        button8.layer.borderWidth = 0.0
        button9.layer.borderWidth = 0.0
        button10.layer.borderWidth = 0.0
        button11.layer.borderWidth = 0.0
        button12.layer.borderWidth = 0.0
        button13.layer.borderWidth = 0.0
    }
    @IBAction func colour2(_ sender: Any) {
        button2.layer.borderWidth = 5.0
        selectedColourString = "#FA6F52"
        
        button1.layer.borderWidth = 0.0
        button0.layer.borderWidth = 0.0
        button3.layer.borderWidth = 0.0
        button4.layer.borderWidth = 0.0
        button5.layer.borderWidth = 0.0
        button6.layer.borderWidth = 0.0
        button7.layer.borderWidth = 0.0
        button8.layer.borderWidth = 0.0
        button9.layer.borderWidth = 0.0
        button10.layer.borderWidth = 0.0
        button11.layer.borderWidth = 0.0
        button12.layer.borderWidth = 0.0
        button13.layer.borderWidth = 0.0
    }
    @IBAction func colour3(_ sender: Any) {
        button3.layer.borderWidth = 5.0
        selectedColourString = "#AD6942"
        
        button1.layer.borderWidth = 0.0
        button2.layer.borderWidth = 0.0
        button0.layer.borderWidth = 0.0
        button4.layer.borderWidth = 0.0
        button5.layer.borderWidth = 0.0
        button6.layer.borderWidth = 0.0
        button7.layer.borderWidth = 0.0
        button8.layer.borderWidth = 0.0
        button9.layer.borderWidth = 0.0
        button10.layer.borderWidth = 0.0
        button11.layer.borderWidth = 0.0
        button12.layer.borderWidth = 0.0
        button13.layer.borderWidth = 0.0
    }
    @IBAction func colour4(_ sender: Any) {
        button4.layer.borderWidth = 5.0
        selectedColourString = "#F9CF02"
        
        button1.layer.borderWidth = 0.0
        button2.layer.borderWidth = 0.0
        button3.layer.borderWidth = 0.0
        button0.layer.borderWidth = 0.0
        button5.layer.borderWidth = 0.0
        button6.layer.borderWidth = 0.0
        button7.layer.borderWidth = 0.0
        button8.layer.borderWidth = 0.0
        button9.layer.borderWidth = 0.0
        button10.layer.borderWidth = 0.0
        button11.layer.borderWidth = 0.0
        button12.layer.borderWidth = 0.0
        button13.layer.borderWidth = 0.0
    }
    @IBAction func colour5(_ sender: Any) {
        button5.layer.borderWidth = 5.0
        selectedColourString = "#A0D369"
        
        button1.layer.borderWidth = 0.0
        button2.layer.borderWidth = 0.0
        button3.layer.borderWidth = 0.0
        button4.layer.borderWidth = 0.0
        button0.layer.borderWidth = 0.0
        button6.layer.borderWidth = 0.0
        button7.layer.borderWidth = 0.0
        button8.layer.borderWidth = 0.0
        button9.layer.borderWidth = 0.0
        button10.layer.borderWidth = 0.0
        button11.layer.borderWidth = 0.0
        button12.layer.borderWidth = 0.0
        button13.layer.borderWidth = 0.0
    }
    @IBAction func colour6(_ sender: Any) {
        button6.layer.borderWidth = 5.0
        selectedColourString = "#1A8F00"
        
        button1.layer.borderWidth = 0.0
        button2.layer.borderWidth = 0.0
        button3.layer.borderWidth = 0.0
        button4.layer.borderWidth = 0.0
        button5.layer.borderWidth = 0.0
        button0.layer.borderWidth = 0.0
        button7.layer.borderWidth = 0.0
        button8.layer.borderWidth = 0.0
        button9.layer.borderWidth = 0.0
        button10.layer.borderWidth = 0.0
        button11.layer.borderWidth = 0.0
        button12.layer.borderWidth = 0.0
        button13.layer.borderWidth = 0.0
    }
    
    @IBAction func colour7(_ sender: Any) {
        button7.layer.borderWidth = 5.0
        selectedColourString = "#48CFAD"
        
        button1.layer.borderWidth = 0.0
        button2.layer.borderWidth = 0.0
        button3.layer.borderWidth = 0.0
        button4.layer.borderWidth = 0.0
        button5.layer.borderWidth = 0.0
        button6.layer.borderWidth = 0.0
        button0.layer.borderWidth = 0.0
        button8.layer.borderWidth = 0.0
        button9.layer.borderWidth = 0.0
        button10.layer.borderWidth = 0.0
        button11.layer.borderWidth = 0.0
        button12.layer.borderWidth = 0.0
        button13.layer.borderWidth = 0.0
    }
    @IBAction func colour8(_ sender: Any) {
        button8.layer.borderWidth = 5.0
        selectedColourString = "#50BFE8"
        
        button1.layer.borderWidth = 0.0
        button2.layer.borderWidth = 0.0
        button3.layer.borderWidth = 0.0
        button4.layer.borderWidth = 0.0
        button5.layer.borderWidth = 0.0
        button6.layer.borderWidth = 0.0
        button7.layer.borderWidth = 0.0
        button0.layer.borderWidth = 0.0
        button9.layer.borderWidth = 0.0
        button10.layer.borderWidth = 0.0
        button11.layer.borderWidth = 0.0
        button12.layer.borderWidth = 0.0
        button13.layer.borderWidth = 0.0
    }
    @IBAction func colour9(_ sender: Any) {
        button9.layer.borderWidth = 5.0
        selectedColourString = "#3f51B5"
        
        button1.layer.borderWidth = 0.0
        button2.layer.borderWidth = 0.0
        button3.layer.borderWidth = 0.0
        button4.layer.borderWidth = 0.0
        button5.layer.borderWidth = 0.0
        button6.layer.borderWidth = 0.0
        button7.layer.borderWidth = 0.0
        button8.layer.borderWidth = 0.0
        button0.layer.borderWidth = 0.0
        button10.layer.borderWidth = 0.0
        button11.layer.borderWidth = 0.0
        button12.layer.borderWidth = 0.0
        button13.layer.borderWidth = 0.0
    }
    @IBAction func colour10(_ sender: Any) {
        button10.layer.borderWidth = 5.0
        selectedColourString = "#625DCC"
        
        button1.layer.borderWidth = 0.0
        button2.layer.borderWidth = 0.0
        button3.layer.borderWidth = 0.0
        button4.layer.borderWidth = 0.0
        button5.layer.borderWidth = 0.0
        button6.layer.borderWidth = 0.0
        button7.layer.borderWidth = 0.0
        button8.layer.borderWidth = 0.0
        button9.layer.borderWidth = 0.0
        button0.layer.borderWidth = 0.0
        button11.layer.borderWidth = 0.0
        button12.layer.borderWidth = 0.0
        button13.layer.borderWidth = 0.0
    }
    @IBAction func colour11(_ sender: Any) {
        button11.layer.borderWidth = 5.0
        selectedColourString = "#AC92ED"
        
        button1.layer.borderWidth = 0.0
        button2.layer.borderWidth = 0.0
        button3.layer.borderWidth = 0.0
        button4.layer.borderWidth = 0.0
        button5.layer.borderWidth = 0.0
        button6.layer.borderWidth = 0.0
        button7.layer.borderWidth = 0.0
        button8.layer.borderWidth = 0.0
        button9.layer.borderWidth = 0.0
        button10.layer.borderWidth = 0.0
        button0.layer.borderWidth = 0.0
        button12.layer.borderWidth = 0.0
        button13.layer.borderWidth = 0.0
    }
    @IBAction func colour12(_ sender: Any) {
        button12.layer.borderWidth = 5.0
        selectedColourString = "#656D77"
        
        button1.layer.borderWidth = 0.0
        button2.layer.borderWidth = 0.0
        button3.layer.borderWidth = 0.0
        button4.layer.borderWidth = 0.0
        button5.layer.borderWidth = 0.0
        button6.layer.borderWidth = 0.0
        button7.layer.borderWidth = 0.0
        button8.layer.borderWidth = 0.0
        button9.layer.borderWidth = 0.0
        button10.layer.borderWidth = 0.0
        button11.layer.borderWidth = 0.0
        button0.layer.borderWidth = 0.0
        button13.layer.borderWidth = 0.0
    }
    @IBAction func colour13(_ sender: Any) {
        button13.layer.borderWidth = 5.0
        selectedColourString = "#000000"
        
        button1.layer.borderWidth = 0.0
        button2.layer.borderWidth = 0.0
        button3.layer.borderWidth = 0.0
        button4.layer.borderWidth = 0.0
        button5.layer.borderWidth = 0.0
        button6.layer.borderWidth = 0.0
        button7.layer.borderWidth = 0.0
        button8.layer.borderWidth = 0.0
        button9.layer.borderWidth = 0.0
        button10.layer.borderWidth = 0.0
        button11.layer.borderWidth = 0.0
        button12.layer.borderWidth = 0.0
        button0.layer.borderWidth = 0.0
    }
    
}
