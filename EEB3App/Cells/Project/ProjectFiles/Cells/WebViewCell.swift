//
//  WebViewCell.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 29/12/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebViewCell: UITableViewCell{
    
    @IBOutlet weak var webView: WKWebView!
    
    override func awakeFromNib() {
        //webView.uiDelegate = self as? WKUIDelegate
        //webView.navigationDelegate = self as? WKNavigationDelegate
    }
    func displayContent(url: String){
        if let url = URL(string: url) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
}
