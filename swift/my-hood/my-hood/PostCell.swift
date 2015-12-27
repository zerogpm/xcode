//
//  PostCell.swift
//  my-hood
//
//  Created by Jian Su on 12/26/15.
//  Copyright © 2015 Jian Su. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    @IBOutlet weak var postImg:UIImageView!
    @IBOutlet weak var titleLbl:UILabel!
    @IBOutlet weak var descLbl:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        postImg.layer.cornerRadius = postImg.frame.size.width / 2
        postImg.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(post:Post) {
        titleLbl.text = post.title
        descLbl.text = post.postDesc
        postImg.image = DataService.instance.imageForPath(post.imagePath)
    }

}
