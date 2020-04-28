//
//  AmazonViewController.swift
//  Library2
//
//  Created by Kenneth Scanlon on 4/24/20.
//  Copyright © 2020 Kenneth Scanlon. All rights reserved.
//

import Foundation
import WebKit

class AmazonViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var urlString: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: urlString!)
        let request = URLRequest(url: url! as URL)
        webView.load(request)
    }

}
