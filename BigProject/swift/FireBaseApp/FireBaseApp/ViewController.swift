//
//  ViewController.swift
//  FireBaseApp
//
//  Created by Jian Su on 7/4/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: #selector(handleLogout))
    
    //user is not logged in
    if FIRAuth.auth()?.currentUser?.uid == nil {
      performSelector(#selector(handleLogout), withObject: nil)
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

