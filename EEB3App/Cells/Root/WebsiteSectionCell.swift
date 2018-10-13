//
//  WebsiteSectionCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 06/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class WebsiteSectionCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var websiteCornerView: UIView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var websiteCollectionView: UICollectionView!
    
    func displayContent(sectionTitle: String){
        websiteCornerView.layer.cornerRadius = Variables.cornerRadius
        websiteCornerView.layer.masksToBounds = true
        
        Title.text = sectionTitle
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        websiteCollectionView.dataSource = self as UICollectionViewDataSource
        websiteCollectionView.delegate = self as UICollectionViewDelegate
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //Set selected
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WebsiteCell
        
        cell.displayContent(banner: Variables.schoolBanner!, title: Variables.schoolName, websiteDescription: "School", titleColor: Variables.primaryColor)
        
        return cell
    }
}
