//
//  QuickHelpSettings.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 13/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

let quickHelpIcon: [UIImage] = [UIImage(named: "info")!, UIImage(named: "mail")!, UIImage(named: "star")!, UIImage(named: "star")!, UIImage(named: "star")!, UIImage(named: "star")!]
let quickHelpTitle: [String] = ["Introduction", "Feedback", "Credits", "Feedback", "Feedback", "Feedback"]
let quickHelpColor: String = "#ffffff"

class QuickHelpSettings: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var delegate:MyCustomCellDelegator!
    @IBOutlet weak var collectionView: UICollectionView!
    
    func displayContent(){
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self as UICollectionViewDataSource
        collectionView.delegate = self as UICollectionViewDelegate
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "quickHelpCell", for: indexPath) as! QuickHelp
        
        cell.displayContent(icon: quickHelpIcon[indexPath.row], title: quickHelpTitle[indexPath.row], color: quickHelpColor)
        
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))

        return cell
    }
    
    func tap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: location)
        print("indexPath of the cell tapped is \(indexPath!.row)")
        let mydata = indexPath!
        if(self.delegate != nil){ //Just to be safe.
            self.delegate.callSegueFromCell(myData: mydata)
        }
    }
    
}
