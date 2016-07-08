//
//  ViewController.swift
//  FireBaseApp
//
//  Created by Jian Su on 7/4/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import UIKit
import Firebase

class MessagesController: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: #selector(handleLogout))
    let image = UIImage(named: "new_message_icon")
    navigationItem.rightBarButtonItem = UIBarButtonItem(image: image, style: .Plain, target: self, action: #selector(handleNewMessage))
    checkIfUserIsLoggedIn()
  }
  
  func handleNewMessage() {
    let newMessageController = NewMessageController()
    let navController = UINavigationController(rootViewController: newMessageController)
    presentViewController(navController, animated: true, completion: nil)
  }
  
  func checkIfUserIsLoggedIn() {
    //user is not logged in
    if FIRAuth.auth()?.currentUser?.uid == nil {
      performSelector(#selector(handleLogout), withObject: nil)
    } else {
      let uid = FIRAuth.auth()?.currentUser?.uid
      FIRDatabase.database().reference().child("user").child(uid!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
        
        if let dictionary = snapshot.value as? [String: AnyObject] {
            self.navigationItem.title = dictionary["name"] as? String
        }
        
      }, withCancelBlock:nil)
    }
  }
  
  func handleLogout() {
    
    do {
      try FIRAuth.auth()?.signOut()
    } catch let logoutError {
      print(logoutError)
    }
    
    let loginController = LoginController()
    presentViewController(loginController, animated:true,completion:nil)
  }

}

