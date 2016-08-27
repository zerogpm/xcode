//
//  TimeOffCell.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-07-06.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit
import AFDateHelper

class TimeOffCell: UITableViewCell {
    @IBOutlet weak var status: UILabel!

    @IBOutlet weak var timeRange: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(timeOffData: TimeOff) {
        
        let startDateNSDate = NSDate(fromString: timeOffData.startDate, format: .Custom("yyyy-MM-dd H:mm:ss"))
        
        let endDateNSDate = NSDate(fromString: timeOffData.endDate, format:
            .Custom("yyyy-MM-dd H:mm:ss"))
        
        let yearStart = startDateNSDate.year()
        let dayStart = startDateNSDate.day()
        let monthStart = startDateNSDate.monthToString()
        
        let yearEnd = endDateNSDate.year()
        let dayEnd = endDateNSDate.day()
        let monthEnd = endDateNSDate.monthToString()
        
        if timeOffData.isApproved == "0" {
            
            timeRange.text = "\(monthStart) \(dayStart), \(yearStart) - \(monthEnd ) \(dayEnd), \(yearEnd)"
            status.text = "Time Off Pending approval"
            
        } else {
            
            timeRange.text = "\(monthStart) \(dayStart), \(yearStart) - \(monthEnd ) \(dayEnd), \(yearEnd)"
            status.textColor = UIColor(red: 129/255, green: 189/255, blue: 65/255, alpha: 1.0) 
            status.text = "Time Off Approved"
            
        }
    }

}
