//
//  AvailabilityCell.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-06-30.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit
import AFDateHelper

class AvailabilityCell: UITableViewCell {

    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var effectiveStart: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(availability: AvailabilityHistory) {
        
        let effecitveStartDateObject = NSDate(fromString: availability.effectiveStartdate, format: .Custom("yyyy-MM-dd HH:mm:ss"))
        let effecitveEndDateObject = NSDate(fromString: availability.effectiveEndDate, format: .Custom("yyyy-MM-dd HH:mm:ss"))
        
        if availability.approved == "0" {
            message.text = "Availability Pending Approval"
            let year = effecitveStartDateObject.year()
            let day = effecitveStartDateObject.day()
            let month = effecitveStartDateObject.monthToString()
            let effectiveStartdateString = "\(month) \(day), \(year)"
            effectiveStart.text = effectiveStartdateString
            
        } else {
            
            let year = effecitveEndDateObject.year()
            let day = effecitveEndDateObject.day()
            let month = effecitveEndDateObject.monthToString()
            
            let yearS = effecitveStartDateObject.year()
            let dayS = effecitveStartDateObject.day()
            let monthS = effecitveStartDateObject.monthToString()
            let effectiveStartdateString = "\(monthS) \(dayS), \(yearS)"
            
            if year == 9999 {
                
                let effectiveDateString = "\(effectiveStartdateString)"
                effectiveStart.text = effectiveDateString
                
            } else {
                let effectiveDateString = "\(effectiveStartdateString) - \(month) \(day), \(year)"
                effectiveStart.text = effectiveDateString
            }

            message.textColor = UIColor(red: 129/255, green: 189/255, blue: 65/255, alpha: 1.0)
            message.text = "Availability Approved"
        }
    }

}
