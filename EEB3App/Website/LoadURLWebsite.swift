//
//  LoadURLWebsite.swift
//  EEB3App
//
//  Created by Anirudhh Ramesh on 30/10/2018.
//  Copyright © 2018 RAMESH anirudhh. All rights reserved.
//

import Foundation
import WebKit

class LoadURLWebsite: UIViewController{
    
    let webView = WKWebView()
    
    override func loadView() {
        self.view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: selectedWebsiteLink) {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
}
