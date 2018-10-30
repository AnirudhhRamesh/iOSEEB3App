//
//  ProjectViewCollectionViewCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 05/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class ProjectViewSectionCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var CollectionCornerView: UIView!
    @IBOutlet weak var ProjectCollectionTitle: UILabel!
    @IBOutlet weak var ProjectCollectionView: UICollectionView!
    
    func displayContent(cellTitle: String, cellDescription: String){
        CollectionCornerView.layer.cornerRadius = Variables.cornerRadius
        CollectionCornerView.layer.masksToBounds = true
        
        ProjectCollectionTitle.text = cellTitle
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ProjectCollectionView.dataSource = self as UICollectionViewDataSource
        ProjectCollectionView.delegate = self as UICollectionViewDelegate
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "projectCell", for: indexPath) as! ProjectViewIconCell
        
        cell.displayContent(banner: Variables.schoolBanner!, title: "Springfest 2019")
        
        return cell
    }
}
