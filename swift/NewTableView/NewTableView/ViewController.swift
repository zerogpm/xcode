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
    
    var girls = ["http://i620.photobucket.com/albums/tt289/laikepo/Pretty%20Girls/LinYingzhen01.jpg",
        "http://tokyofashion.com/wp-content/uploads/2009/06/fashion-brands-big.jpg",
        "https://pbs.twimg.com/profile_images/655396221570437122/Lg-OUCC1.jpg",
        "http://1.bp.blogspot.com/-NrLIjUHEnXc/UjA6up6nIvI/AAAAAAAAUsg/g0trxNmwZ3A/s1600/capture-20130911-051229.png",
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

