//
//  ViewController.swift
//  BrainTeaser
//
//  Created by Jian Su on 2016-03-14.
//  Copyright © 2016 ZeroTech. All rights reserved.
//

import UIKit
import pop

class LoginVC: UIViewController {

  @IBOutlet weak var emailConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var passwordConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var loginConstraint: NSLayoutConstraint!
  
  var animEngine:AnimationEngine!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.animEngine = AnimationEngine(constraints: [emailConstraint, passwordConstraint, loginConstraint])
  }
  
  override func viewDidAppear(animated: Bool) {
    self.animEngine.animateOnScreen(1)
  }


}

