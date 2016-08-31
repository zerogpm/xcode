//
//  ViewController.swift
//  socialNetworking
//
//  Created by Jian Su on 2016-08-25.
//  Copyright © 2016 ZeroTech. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var scroll: UIScrollView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    textField.delegate = self
    scroll.backgroundColor = UIColor(red: 16/255, green: 19/255, blue: 19/255, alpha: 1.0)
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldDidBeginEditing(textField: UITextField) {
    scroll.setContentOffset(CGPointMake(0, 100), animated: true)
  }
  
  func textFieldDidEndEditing(textField: UITextField) {
    scroll.setContentOffset(CGPointMake(0, 0), animated: true)
  }
}

