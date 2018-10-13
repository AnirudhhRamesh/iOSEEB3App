//
//  ImageCropper.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 06/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

class ImageCropper: UIViewController, UIScrollViewDelegate{
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewWidth: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setImageToCrop
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    @IBAction func cropTapped(_ sender: Any){
        //crop()
    }
    
    func setImageToCrop(image:UIImage){
        imageView.image = image
        imageViewWidth.constant = image.size.width
        imageViewHeight.constant = image.size.height
        let scaleHeight = scrollView.frame.size.width/image.size.width
        let scaleWidth = scrollView.frame.size.height/image.size.height
        let maxScale = max(scaleWidth, scaleHeight)
        scrollView.minimumZoomScale = maxScale
        scrollView.zoomScale = maxScale
    }
    
    func crop() {
        let scale:CGFloat = 1/scrollView.zoomScale
        let x:CGFloat = scrollView.contentOffset.x * scale
        let y:CGFloat = scrollView.contentOffset.y * scale
        let width:CGFloat = scrollView.frame.size.width * scale
        let height:CGFloat = scrollView.frame.size.height * scale
        let croppedCGImage = imageView.image?.cgImage?.cropping(to: CGRect(x: x, y: y, width: width, height: height))
        let croppedImage = UIImage(cgImage: croppedCGImage!)
        setImageToCrop(image: croppedImage)
        //Save Cropped Image to a Shared Preferences
    }
    
}
