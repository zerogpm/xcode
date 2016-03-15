//
//  CustomTextField.swift
//  BrainTeaser
//
//  Created by Jian Su on 2016-03-14.
//  Copyright © 2016 ZeroTech. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextField: UITextField {
  
  @IBInspectable var inset:CGFloat = 0
  @IBInspectable var cornerRadius:CGFloat = 5.0 {
    didSet {
      setUpView()
    }
  }
  
  override func textRectForBounds(bounds: CGRect) -> CGRect {
    return CGRectInset(bounds, inset, inset)
  }
  
  override func editingRectForBounds(bounds: CGRect) -> CGRect {
    return textRectForBounds(bounds)
  }
  
  override func awakeFromNib() {
    self.layer.cornerRadius = 5.0
  }
  
  override func prepareForInterfaceBuilder() {
    super.prepareForInterfaceBuilder()
    setUpView()
  }
  
  func setUpView() {
    self.layer.cornerRadius = cornerRadius
  }
  
  
  
  
}
