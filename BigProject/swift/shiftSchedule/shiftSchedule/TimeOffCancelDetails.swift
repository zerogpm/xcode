//
//  TimeOffCancelDetails.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-07-07.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit
import AFDateHelper

class TimeOffCancelDetails: UIViewController {
    @IBOutlet weak var timeRange: UILabel!

    @IBOutlet weak var notes: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var CancelBtnLabel: UIButton!
    var timeOffData : TimeOff!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSetUp(timeOffData)
        dump(timeOffData)
    }
    
    func initSetUp(timeOff: TimeOff) {
        
        let startDateNSDate = NSDate(fromString: timeOffData.startDate, format: .Custom("yyyy-MM-dd H:mm:ss"))
        
        let endDateNSDate = NSDate(fromString: timeOffData.endDate, format:
            .Custom("yyyy-MM-dd H:mm:ss"))
        
        let yearStart = startDateNSDate.year()
        let dayStart = startDateNSDate.day()
        let monthStart = startDateNSDate.monthToString()
        
        let yearEnd = endDateNSDate.year()
        let dayEnd = endDateNSDate.day()
        let monthEnd = endDateNSDate.monthToString()
        
        
        if timeOff.isApproved == "0" {
            
            timeRange.text = "\(monthStart) \(dayStart), \(yearStart) - \(monthEnd ) \(dayEnd), \(yearEnd)"
            status.text = "Availability Pending Approval"
            
        } else {
            timeRange.text = "\(monthStart) \(dayStart), \(yearStart) - \(monthEnd ) \(dayEnd), \(yearEnd)"
            CancelBtnLabel.setTitle("Return", forState: .Normal)
            CancelBtnLabel.backgroundColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
            status.textColor = UIColor(red: 129/255, green: 189/255, blue: 65/255, alpha: 1.0)
            status.text = "Time off Approved"
        }
        
        notes.text = timeOffData.notes
    }
    
    @IBAction func cancelBtnPressed(sender: UIButton) {
        
        if timeOffData.isApproved == "0" {
            
            let timeOffCancel = timeOffModel(availabilityId: timeOffData.id)
            timeOffCancel.cancelTimeOff({ (responseObject, error) in
                
                if error == nil {
                    print("No Error \(responseObject)")
                    self.navigationController?.popViewControllerAnimated(true)
                } else {
                    print("Error: \(error)")
                }
                
            })
            
            
        } else {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
}
