//
//  DetailHeaderView.swift
//  Photos-DucTran
//
//  Created by Jian Su on 3/8/17.
//  Copyright © 2017 Developers Academy. All rights reserved.
//

import UIKit

class DetailHeaderView: UIView {
  
  @IBOutlet weak var imageView: UIImageView!
  
  var image: UIImage? {
    didSet {
      if let image = image {
        imageView.image = image
      } else {
        imageView.image = nil
      }
    }
  }
}
