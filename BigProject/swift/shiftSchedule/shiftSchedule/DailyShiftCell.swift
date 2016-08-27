//
//  DailyShiftCell.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-03-21.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit

class DailyShiftCell: UITableViewCell {
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var timeRange: UILabel!
    @IBOutlet weak var presetName: UILabel!
    
    @IBOutlet weak var initial: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(dailyShift: DailyShift) {
        
        let firstInitial = String(dailyShift.fullName[dailyShift.fullName.startIndex])
        
        
        if let rangOfEmptySpace = dailyShift.fullName.rangeOfString(" ", options: NSStringCompareOptions.BackwardsSearch) {
            let suffix = String(dailyShift.fullName.characters.suffixFrom(rangOfEmptySpace.endIndex))
            
            let secondInitial = String(suffix[suffix.startIndex])
            
            initial.text = "\(firstInitial.uppercaseString)\(secondInitial.uppercaseString)"
        }
        
        
        
        self.date.text = dailyShift.date
        self.fullName.text = dailyShift.fullName
        self.position.text = dailyShift.position
        self.timeRange.text = dailyShift.timeRange
        if(dailyShift.presetName == "no preset") {
            self.presetName.text = ""
        } else {
            self.presetName.text = dailyShift.presetName
        }
    }

}
