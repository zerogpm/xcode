//
//  ViewController.swift
//  webRequest
//
//  Created by Jian Su on 11/19/15.
//  Copyright © 2015 Jian Su. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var container: UIView!
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        container.addSubview(webView)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        let frame = CGRectMake(0, 0, container.bounds.width, container.bounds.height)
        webView.frame = frame
        loadRequest("http://cq.sanguosha.com/home")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadRequest(urlString:String) {
        
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        webView.loadRequest(request)
    }

    @IBAction func loopSanguo(sender: AnyObject) {
        loadRequest("http://cq.sanguosha.com/home")
    }

    @IBAction func loopPlurasigh(sender: AnyObject) {
        loadRequest("https://www.pluralsight.com/")
    }
    
    @IBAction func loadBole(sender: AnyObject) {
        loadRequest("http://blog.jobbole.com/")
    }
    
}

