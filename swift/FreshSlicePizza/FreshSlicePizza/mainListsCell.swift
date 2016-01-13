//
//  mainListsCell.swift
//  FreshSlicePizza
//
//  Created by Chris Su on 2016-01-11.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit

class mainListsCell: UITableViewCell {

    @IBOutlet weak var mainListsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(mainListsLabelText:String) {
        self.mainListsLabel?.text = mainListsLabelText
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
