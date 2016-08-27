//
//  MyScheduleCell.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-03-23.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit

class MyScheduleCell: UITableViewCell {
    
    @IBOutlet weak var timeRange: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var statusBarLabel: UILabel!
    
    @IBOutlet weak var presetName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(mySchedule: MySchedule) {
        
        if mySchedule.presetName == "No Preset" {
            self.presetName.text = ""
        } else {
            self.presetName.text = mySchedule.presetName
        }
        self.position.text = mySchedule.position
        self.timeRange.text = mySchedule.timeRange
        if mySchedule.status == "No status" {
            self.statusBarLabel.hidden = true
            self.accessoryType = .None
        } else if mySchedule.status == "Editable" {
            self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            self.statusBarLabel.text = "Swap / Release"
            self.statusBarLabel.textColor = UIColor(hue: 213/360, saturation: 84/100, brightness: 79/100, alpha: 1.0)
            self.statusBarLabel.hidden = false
        } else if mySchedule.status == "pending_swap" {
            self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            self.statusBarLabel.text = "Pending Swap"
            self.statusBarLabel.hidden = false
        } else if mySchedule.status == "release_pending_pickup" {
            self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            self.statusBarLabel.text = "Pending Release"
            self.statusBarLabel.textColor = UIColor(red: 243/255, green: 156/255, blue: 18/255, alpha: 1.0)
            self.statusBarLabel.hidden = false
        }
    }
}
