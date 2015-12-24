//
//  ViewController.swift
//  NewTableView
//
//  Created by Jian Su on 11/21/15.
//  Copyright © 2015 Jian Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var girls = ["https://s-media-cache-ak0.pinimg.com/736x/7a/1e/4e/7a1e4e05ab12e97409e930951bb086f9.jpg",
        "https://s-media-cache-ak0.pinimg.com/736x/25/63/e2/2563e2e716dec36a1128157e6c665801.jpg",
        "https://pbs.twimg.com/profile_images/655396221570437122/Lg-OUCC1.jpg",
        "https://hearingade.files.wordpress.com/2012/01/tumblr_l977297e3x1qaoz86o1_500.jpg",
        "https://pbs.twimg.com/profile_images/481982697720406016/2LXKwxnC_400x400.jpeg"]
    
    var girlsTitle = ["Chinese Girls", "Japanese Girls", "France Girls", "England Girl", "US girl"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("girls") as? girlCell {
            
            var img: UIImage!
            
            let url = NSURL(string: girls[indexPath.row])!
            
            if let data = NSData(contentsOfURL: url) {
                img = UIImage(data: data)
            } else {
                img = UIImage(named: "girl")
            }
            
            cell.configureCell(img, text: girlsTitle[indexPath.row])
            
            return cell
        } else {
            return girlCell()
        }
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return girls.count
    }
}

