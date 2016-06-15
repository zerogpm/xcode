//
//  ViewController.swift
//  textDelegate
//
//  Created by Jian Su on 2016-06-14.
//  Copyright © 2016 ZeroTech. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

  @IBOutlet weak var wecao: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    wecao.delegate = self
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  func textFieldShouldReturn(textField: UITextField) -> Bool {
    wecao.resignFirstResponder()
    return true
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    self.view.endEditing(true)
  }
}

