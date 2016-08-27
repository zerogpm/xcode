//
//  reavealMenuCell.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-05-18.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit

class reavealMenuCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var menuText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(menuList: String, indexPathIndex:Int) {
        self.menuText.text = menuList
        switch indexPathIndex {
        case 0:
           self.icon.image = UIImage(named: "MyScheudle")
        case 1:
           self.icon.image = UIImage(named: "daily")
        case 2:
           self.icon.image = UIImage(named: "MyShiftSwap")
        case 3:
            self.icon.image = UIImage(named: "pickupShiftRelease")
        case 4:
            self.icon.image = UIImage(named: "Setting")
        case 5:
            self.icon.image = UIImage(named: "Availability")
        case 6:
            self.icon.image = UIImage(named: "cancelMyShiftRelease")
        case 7:
            self.icon.image = UIImage(named: "logoutSetting")
        default:
            return
        }
    }

}
