//
//  CustomDetailVC.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-07-08.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit
import AFDateHelper

class CustomDetailVC: UIViewController {
    
    @IBOutlet weak var cancelBtnOutlet: UIButton!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var hourRange: UILabel!
    @IBOutlet weak var monDateYear: UILabel!
    var customTimeOff : TimeOff!
    var startTime = NSDate()
    var endTime = NSDate()
    var headerDate = NSDate()

    override func viewDidLoad() {
        super.viewDidLoad()
        initSetup()
    }
    
    func initSetup() {
        
        startTime = NSDate(fromString: customTimeOff.startDate, format:
            .Custom("yyyy-MM-dd HH:mm:ss"))
        endTime = NSDate(fromString: customTimeOff.endDate, format:
            .Custom("yyyy-MM-dd HH:mm:ss"))
        headerDate = NSDate(fromString: customTimeOff.startDate, format:
        .Custom("yyyy-MM-dd HH:mm:ss"))
        
        let headerDateString = headerDate.toString(format: .Custom("MMM dd, yyyy"))
        let startTimeString = startTime.toString(format: .Custom("h:mma"))
        let endTimeString = endTime.toString(format: .Custom("h:mma"))
        
        hourRange.text = "\(startTimeString) - \(endTimeString)"
        monDateYear.text = headerDateString
        
        if customTimeOff.isApproved == "0" {
            
            status.text = "Temporary Availability Pending Approval"
            
        } else {
            cancelBtnOutlet.setTitle("Return", forState: .Normal)
            cancelBtnOutlet.backgroundColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
            status.textColor = UIColor(red: 129/255, green: 189/255, blue: 65/255, alpha: 1.0)
            status.text = "Temporary Availability Approved"
        }
        
    }
    
    @IBAction func cancelBtnPressed(sender: UIButton) {
        
        if customTimeOff.isApproved == "0" {
            
            let timeOffCancel = timeOffModel(availabilityId: customTimeOff.id)
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
