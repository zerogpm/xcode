//
//  girlCell.swift
//  NewTableView
//
//  Created by Jian Su on 11/21/15.
//  Copyright © 2015 Jian Su. All rights reserved.
//

import UIKit

class girlCell: UITableViewCell {

    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var mainLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        mainImg.layer.cornerRadius = 5.0
        mainImg.clipsToBounds = true
    }
    
    func configureCell(image:UIImage, text:String) {
        mainImg.image = image
        mainLbl.text = text
    }

}
