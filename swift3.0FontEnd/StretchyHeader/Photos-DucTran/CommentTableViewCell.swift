//
//  CommentTableViewCell.swift
//  Photos-DucTran
//
//  Created by Jian Su on 3/8/17.
//  Copyright © 2017 Developers Academy. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var commentTextLabel: UILabel!
  
  var comment:Comment? {
    didSet {
      if let comment = comment {
        userNameLabel.text = comment.user.toString()
        userNameLabel.textColor = comment.user.toColor()
        commentTextLabel.text = comment.text
      } else {
        userNameLabel.text = nil
        commentTextLabel.text = nil
      }
    }
  }

}
