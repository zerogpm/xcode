//
//  NewMessageController.swift
//  FireBaseApp
//
//  Created by Jian Su on 7/7/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController {
  
  let cellId = "cellId"
  var users = [User]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: #selector(handleCancel))
    tableView.registerClass(UserCell.self, forCellReuseIdentifier: cellId)
    fetchUser()
  }
  
  func fetchUser() {
    FIRDatabase.database().reference().child("user").observeEventType(.ChildAdded, withBlock: { (snapshot) in
      
      if let dictionary = snapshot.value as? [String:AnyObject] {
        let user = User()
        //if you use this setter, your app will crash if your class properties don't exactly match up with the firebase dictionary keys
        user.setValuesForKeysWithDictionary(dictionary)
        self.users.append(user)
        //this will crash because of background thread, so lets use dispatch_async to fix
        dispatch_async(dispatch_get_main_queue(), { 
          self.tableView.reloadData()
        })
      }
      
      }, withCancelBlock: nil)
  }
  
  func handleCancel() {
    dismissViewControllerAnimated(true, completion: nil)
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
    
    let user = users[indexPath.row]
    
    cell.textLabel?.text = user.name
    cell.detailTextLabel?.text = user.email
    return cell
  }
  
}

class UserCell: UITableViewCell {
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
