//
//  ViewController.swift
//  Fix-UITextField-Problem
//
//  Created by Jian Su on 2016-08-27.
//  Copyright © 2016 ZeroTech. All rights reserved.
//

/*
 1. add a scroll view
 2. UItext field must under scroll view
 3. set scrollView contenOffSet
 */

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var wantToPushTextField: UITextField!

  override func viewDidLoad() {
    super.viewDidLoad()
    scrollView.backgroundColor = UIColor.brownColor()
    wantToPushTextField.delegate = self
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  func textFieldDidBeginEditing(textField: UITextField) {
    scrollView.setContentOffset(CGPointMake(0, 259), animated: true)
  }
  
  func textFieldDidEndEditing(textField: UITextField) {
    scrollView.setContentOffset(CGPointMake(0, 0), animated: true)
  }

}

