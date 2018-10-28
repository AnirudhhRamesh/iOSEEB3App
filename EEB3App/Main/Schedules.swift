//
//  Schedules.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 20/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

var screenHeight: CGFloat = 0

@available(iOS 11.0, *)
class Schedules: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet var rootView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //Heights of Navigation and tabBar sizes
    var topBar: CGFloat = 0
    var bottomBar: CGFloat = 0
    
    let columnLayout = ColumnFlowLayout(
        cellsPerRow: 5,
        minimumInteritemSpacing: 0,
        minimumLineSpacing: 0,
        sectionInset: UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        collectionView?.collectionViewLayout = columnLayout
        collectionView?.contentInsetAdjustmentBehavior = .always
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    override func viewLayoutMarginsDidChange() {
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation){
            topBar = (self.navigationController?.navigationBar.frame.height)!
            bottomBar = (self.tabBarController?.tabBar.frame.height)!
            let screenCorrectedHeight = self.view.frame.height - 2*(topBar + bottomBar)
            
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
                screenCorrectedHeight = self.view.frame.height - 1.6*(topBar + bottomBar)
            }
            else{
                screenCorrectedHeight = self.view.frame.height - 1.1*(topBar + bottomBar)
            }
            screenHeight = screenCorrectedHeight
            
            print(self.view.frame.height)
            print(screenCorrectedHeight)
            print(self.collectionView.frame.height)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //CollectionViewCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "day", for: indexPath) as! ScheduleCollectionViewCell
        return cell
    }

}
