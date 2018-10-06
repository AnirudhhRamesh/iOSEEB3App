//
//  Websites.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 02/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class Websites: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            if collectionView == self.collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WebsiteCell
        
            cell.cornerView.layer.cornerRadius = 15
            cell.cornerView.layer.masksToBounds = true
                cell.displayContent(banner: UIImage(named: "EEB3_Logo_Tinted")!, title: "EEB3", websiteDescription: "School", titleColor: Variables.primaryColor)
        
            return cell
        }
            else{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WebsiteCell
        
                cell.cornerView.layer.cornerRadius = 15
                cell.cornerView.layer.masksToBounds = true

                cell.displayContent(banner: UIImage(named:"EEB3_Logo_Cropped_Tinted")!, title: "EEB3 App", websiteDescription: "Student", titleColor: Variables.primaryColor)
                return cell
        }
    }
}
