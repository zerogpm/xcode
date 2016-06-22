//
//  ViewController.swift
//  newButton
//
//  Created by Jian Su on 6/21/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  let MonBtn = UIButton()
  let TueBtn = UIButton()
  let WebBtn = UIButton()
  let ThuBtn = UIButton()
  let FirBtn = UIButton()
  let SatBtn = UIButton()
  let SunBtn = UIButton()
  let buttonViewHolder = UIView()
  
  var views = Dictionary<String, AnyObject>()
  var contraints = [NSLayoutConstraint]()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.buttonViewHolder.backgroundColor = UIColor(red: 220.0/155.0, green: 224.0/255.0, blue: 210.0/255.0, alpha: 1.0)
    
    self.view.addSubview(buttonViewHolder)
    self.buttonViewHolder.translatesAutoresizingMaskIntoConstraints = false
    
    self.views["buttonViewHolder"] = buttonViewHolder
    
    setConstraints()
    
  }
  
  func setConstraints() {
    addConstraint("V:|-0-[buttonViewHolder(50)]")
    addConstraint("H:|-0-[buttonViewHolder]-0-|")
    
    NSLayoutConstraint.activateConstraints(self.contraints)
  }

  func addConstraint(format:String) {
    let newContraints = NSLayoutConstraint.constraintsWithVisualFormat(format, options: [], metrics: nil, views: self.views)
    
    self.contraints += newContraints
  }


}

