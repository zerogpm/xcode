//
//  ViewController.swift
//  Alert
//
//  Created by Jian Su on 6/6/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  @IBAction func first(sender: UIButton) {
    let appearance = SCLAlertView.SCLAppearance(
      kTitleFont: UIFont(name: "HelveticaNeue", size: 20)!,
      kTextFont: UIFont(name: "HelveticaNeue", size: 14)!,
      kButtonFont: UIFont(name: "HelveticaNeue-Bold", size: 14)!,
      showCloseButton: false
    )
    
    let alert = SCLAlertView(appearance: appearance)
    alert.addButton("Second Button") {
      print("Second button tapped")
    }
    alert.showSuccess("Button View", subTitle: "This alert view has buttons")

  }
  
  
  @IBAction func second(sender: UIButton) {
    let alertView = SCLAlertView()
    alertView.addButton("First Button", target:self, selector:#selector(ViewController.omg))
    alertView.addButton("Second Button") {
      print("Second button tapped")
    }
    alertView.showSuccess("Button View", subTitle: "This alert view has buttons")
  }

  func omg() {
    print("omg")
  }
}

