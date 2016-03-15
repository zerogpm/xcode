//
//  CustomButton.swift
//  BrainTeaser
//
//  Created by Jian Su on 2016-03-14.
//  Copyright © 2016 ZeroTech. All rights reserved.
//

import UIKit

@IBDesignable
class CustomButton: UIButton {
  
  @IBInspectable var cornerRadius: CGFloat = 3.0 {
    didSet {
      setupView()
    }
  }
  
  @IBInspectable var fontColor: UIColor = UIColor.whiteColor() {
    didSet {
      self.tintColor = fontColor
    }
  }
  
  override func awakeFromNib() {
    setupView()
  }
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    setupView()
  }
  
  func setupView() {
    self.layer.cornerRadius = cornerRadius
  }
  
}
