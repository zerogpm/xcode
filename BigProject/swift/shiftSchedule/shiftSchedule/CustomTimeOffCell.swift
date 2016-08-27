//
//  CustomTimeOffCell.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-07-08.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit
import AFDateHelper

class CustomTimeOffCell: UITableViewCell {

    @IBOutlet weak var timeRange: UILabel!
    
    @IBOutlet weak var status: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(customTimeOffData: TimeOff) {
        
        let startDateNSDate = NSDate(fromString: customTimeOffData.startDate, format: .Custom("yyyy-MM-dd H:mm:ss"))
        
        let endDateNSDate = NSDate(fromString: customTimeOffData.endDate, format:
            .Custom("yyyy-MM-dd H:mm:ss"))
        
        let yearStart = startDateNSDate.year()
        let dayStart = startDateNSDate.day()
        let monthStart = startDateNSDate.monthToString()
        
        let yearEnd = endDateNSDate.year()
        let dayEnd = endDateNSDate.day()
        let monthEnd = endDateNSDate.monthToString()
        
        
        if customTimeOffData.isApproved == "0" {
            
            timeRange.text = "\(monthStart) \(dayStart), \(yearStart) - \(monthEnd ) \(dayEnd), \(yearEnd)"
            status.text = "Temporary Availability Pending Approval"
            
        } else {
            
            timeRange.text = "\(monthStart) \(dayStart), \(yearStart) - \(monthEnd ) \(dayEnd), \(yearEnd)"
            status.textColor = UIColor(red: 129/255, green: 189/255, blue: 65/255, alpha: 1.0)
            status.text = "Temporary Availability Approved"
        }
        
    }

}
