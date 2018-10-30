//
//  WebsiteSectionCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 06/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

var selectedWebsiteLink: String = "https://office365.eursc.eu"

class WebsiteSectionCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var websiteCornerView: UIView!
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var websiteCollectionView: UICollectionView!

    var currentIndexPath: Int = 0
    let groupedSites = Dictionary(grouping: siteInfos, by: { $0.description })
    
    func displayContent(sectionTitle: String, indexPath: Int){
        websiteCornerView.layer.cornerRadius = Variables.cornerRadius
        websiteCornerView.layer.masksToBounds = true
        
        Title.text = sectionTitle
        currentIndexPath = indexPath
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
        print(groupedSites[siteSections[currentIndexPath]]!)
        for site in groupedSites[siteSections[currentIndexPath]]!{
            print(site.title)
        }
        return groupedSites[siteSections[currentIndexPath]]!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WebsiteCell
        for site in groupedSites[siteSections[currentIndexPath]]!{
            cell.displayContent(title: site.title, banner: Variables.schoolBanner!)
            print(indexPath)
        }
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        return cell
    }

    func tap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.websiteCollectionView)
        let indexPath = self.websiteCollectionView.indexPathForItem(at: location)
        print("indexPath of the cell tapped is \(indexPath!.row)")
        selectedWebsiteLink = "https://www.apple.com"
    }
}
