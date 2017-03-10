//
//  ViewController.swift
//  dynamicRowHeightTableView
//
//  Created by Jian Su on 2017-03-09.
//  Copyright © 2017 ZeroTech. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

  var tableDate:[String] = ["Rod", "Mark", "Lem He is from the philippines, he is a filipino!", "Evans"]
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.estimatedRowHeight = 44
    tableView.rowHeight = UITableViewAutomaticDimension
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableDate.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
    
    if cell == nil {
      cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
    }
    
    cell!.textLabel?.text = tableDate[indexPath.row]
    cell?.textLabel?.numberOfLines = 0
    return cell!
  }
}

