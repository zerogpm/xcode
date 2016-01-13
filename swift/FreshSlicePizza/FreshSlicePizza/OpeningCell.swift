//
//  OpeningCell.swift
//  FreshSlicePizza
//
//  Created by Chris Su on 2016-01-11.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit

class OpeningCell: UITableViewCell {

    @IBOutlet weak var openingListsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(openingData: OpeningData) {
        self.openingListsLabel?.text = openingData.description
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
