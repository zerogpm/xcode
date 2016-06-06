//
//  ViewController.swift
//  image
//
//  Created by Jian Su on 6/4/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
  
  @IBOutlet weak var ImageTable: UITableView!
  let imagelinks = ["http://www.kumakreations.com/wp-content/uploads/2013/12/kill_la_kill_by_fishine02-d6ro0in.png" , "http://i0.kym-cdn.com/photos/images/original/000/732/029/391.jpg", "http://img14.deviantart.net/cd4c/i/2013/294/0/2/kill_la_kill_by_eko999-d6ra08q.jpg", "https://i.ytimg.com/vi/nFGxk2aUBFQ/maxresdefault.jpg","http://vignette1.wikia.nocookie.net/omniversal-crosswars/images/a/ae/Kill-la-kill.jpg/revision/latest?cb=20140111135321","http://vignette2.wikia.nocookie.net/p__/images/7/72/Kill_La_Kill_Satsuki_(0).jpg/revision/latest?cb=20150226001234&path-prefix=protagonist","https://i.ytimg.com/vi/vK5Sn-hGZ7M/maxresdefault.jpg", "http://i2.kym-cdn.com/photos/images/original/000/652/632/24b.png", "https://s-media-cache-ak0.pinimg.com/736x/c5/66/8b/c5668ba601cc5c21c77de3c293c0ea6e.jpg","http://31.media.tumblr.com/8fe7400c154921f2480e0bb6c8aea68d/tumblr_n2t1uaeStS1soe93no7_500.gif"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    ImageTable.dataSource = self
    ImageTable.delegate = self
    
  }
  
  
  
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
  
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    let numberOfSections = 1
    return numberOfSections
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return imagelinks.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    if let cell = tableView.dequeueReusableCellWithIdentifier("cell") as? TableViewCell {
      cell.configureCell(imagelinks[indexPath.row])
      return cell
    } else {
      let cell = TableViewCell()
      return cell
    }
  }
  
}

