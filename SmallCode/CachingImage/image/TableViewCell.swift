//
//  TableViewCell.swift
//  image
//
//  Created by Jian Su on 6/4/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {

  
  @IBOutlet weak var testing: UIImageView!

  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
  func configureCell(list: String) {
    
    let imageUrl = NSURL(string: list)
    
    if let url = imageUrl {
      testing.sd_setImageWithURL(url, placeholderImage: UIImage(named: "test"), options: .RefreshCached)
    } else {
      testing.image = UIImage(named: "test")
    }
    
    
  }

}
