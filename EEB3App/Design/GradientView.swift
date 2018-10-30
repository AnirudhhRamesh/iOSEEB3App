//
//  GradientView.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 29/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class GradientView: UIView {
    var topColor: UIColor = UIColor.black
    var bottomColor: UIColor = UIColor.black
    
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gradientLayer = self.layer as! CAGradientLayer
        gradientLayer.colors = [
            topColor.withAlphaComponent(0).cgColor,
            bottomColor.withAlphaComponent(0.8).cgColor
        ]
        backgroundColor = UIColor.clear
    }
}
