//
//  ViewController.swift
//  socialNetworking
//
//  Created by Jian Su on 2016-08-25.
//  Copyright © 2016 ZeroTech. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var email: UITextField!
  @IBOutlet weak var password: UITextField!
  @IBOutlet weak var firstNameTextField: UITextField!
  @IBOutlet weak var lastNameTextField: UITextField!
  @IBOutlet weak var scroll: UIScrollView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    lastNameTextField.delegate = self
    firstNameTextField.delegate = self
    scroll.backgroundColor = UIColor(red: 16/255, green: 19/255, blue: 19/255, alpha: 1.0)
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    lastNameTextField.resignFirstResponder()
    firstNameTextField.resignFirstResponder()
    return true
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    scroll.setContentOffset(CGPoint(x: 0, y: 100), animated: true)
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    scroll.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
  }
  
  @IBAction func RegisterTapped(_ sender: UIButton) {
    if firstNameTextField.text!.isEmpty || lastNameTextField.text!.isEmpty || password.text!.isEmpty || email.text!.isEmpty {
      firstNameTextField.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [NSForegroundColorAttributeName : UIColor.red])
      lastNameTextField.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: [NSForegroundColorAttributeName  : UIColor.red])
      email.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName : UIColor.red])
      password.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName : UIColor.red])
    } else {
      
    }
  }
  
}

