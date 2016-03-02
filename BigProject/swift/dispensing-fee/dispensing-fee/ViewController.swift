//
//  ViewController.swift
//  dispensing-fee
//
//  Created by Jian Su on 2016-02-28.
//  Copyright © 2016 ZeroTech. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func fbBtnPressed(sender: UIButton!) {
    let facebookLogin = FBSDKLoginManager()
    
    facebookLogin.logInWithReadPermissions(["email"]) { (facebookResult:FBSDKLoginManagerLoginResult!, facebookError: NSError!) -> Void in
      
      if facebookError != nil {
        print("Facebook login failed. Error \(facebookError)")
      } else {
        let accessToken = FBSDKAccessToken.currentAccessToken().tokenString
        print("Successful \(accessToken)")
      }
      
    }
  }


}

