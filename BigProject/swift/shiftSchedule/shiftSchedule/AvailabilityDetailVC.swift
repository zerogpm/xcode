//
//  AvailabilityDetailVC.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-07-04.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit
import AFDateHelper
import SwiftyJSON

class AvailabilityDetailVC: UIViewController {
    
    @IBOutlet weak var requestBtn: UIButton!
    @IBOutlet weak var mondayView: UIView!
    @IBOutlet weak var tuesdayView: UIView!
    @IBOutlet weak var wednesdayView: UIView!
    @IBOutlet weak var thursdayView: UIView!
    @IBOutlet weak var fridayView: UIView!
    @IBOutlet weak var saturdayView: UIView!
    @IBOutlet weak var sundayView: UIView!
    @IBOutlet weak var headerDate: UILabel!
    @IBOutlet weak var headerStatus: UILabel!
    @IBOutlet weak var mondayTimeLable: UILabel!
    @IBOutlet weak var tuesdayTimeLabel: UILabel!
    @IBOutlet weak var wednesdayTimeLabel: UILabel!
    @IBOutlet weak var thursdayTimeLabel: UILabel!
    @IBOutlet weak var fridayTimeLabel: UILabel!
    @IBOutlet weak var satTimeLabel: UILabel!
    @IBOutlet weak var sunTimeLabel: UILabel!
    let formatter = NSDateFormatter()
    var id = ""
    var employeeId = ""
    
    var availabilityData: AvailabilityHistory!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetup()
    }
    
    func initSetup() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let empId = defaults.stringForKey(userId) {
            employeeId = empId
        }
        
        formatter.dateFormat = "h:mm a"
        formatter.AMSymbol = "AM"
        formatter.PMSymbol = "PM"
        
        if availabilityData.approved == "1" {
            requestBtn.backgroundColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
            requestBtn.setTitle("Return", forState: .Normal)
        }
        self.id = availabilityData.id
        updateUI(availabilityData)
    }
    
    func updateUI(availabilityData: AvailabilityHistory) {
        
        if availabilityData.effectiveStartdate != "-0001-11-30 00:00:00" {
            
            let effecitveStartDateObject = NSDate(fromString: availabilityData.effectiveStartdate, format:.Custom("yyyy-MM-dd HH:mm:ss"))
            
            let effecitveEndDateObject = NSDate(fromString: availabilityData.effectiveEndDate, format:.Custom("yyyy-MM-dd HH:mm:ss"))
            
            let year = effecitveStartDateObject.year()
            let day = effecitveStartDateObject.day()
            let month = effecitveStartDateObject.monthToString()
            let effectiveStartdateString = "\(month) \(day), \(year)"
            
            let endYear = effecitveEndDateObject.year()
            let endDay = effecitveEndDateObject.day()
            let endMonth = effecitveEndDateObject.monthToString()
            let effectiveEndDateString = "\(endMonth) \(endDay), \(endYear)"
            
            if endYear == 9999 {
                headerDate.text = "\(effectiveStartdateString)"
            } else {
                headerDate.text = "\(effectiveStartdateString) - \(effectiveEndDateString)"
            }
            
        } else {
            headerDate.text = "Effective Day Expired"
        }
        
        if availabilityData.approved == "0" {
            headerStatus.text = "Availability Pending Approval"
        } else {
            headerStatus.text = "Availability Approved"
            headerStatus.textColor = UIColor(red: 129/255, green: 189/255, blue: 65/255, alpha: 1.0)
        }
        
        if availabilityData.mondayAvailable != "0" {
            updateLabel(mondayView, label: mondayTimeLable, start: availabilityData.mondayStart, end: availabilityData.mondayEnd)
        }
        
        if availabilityData.tuesdayAvailable != "0" {
            updateLabel(tuesdayView, label: tuesdayTimeLabel, start: availabilityData.tuesdayStart, end: availabilityData.tuesdayEnd)
        }
        
        if availabilityData.wednesdayAvailable != "0" {
            updateLabel(wednesdayView, label: wednesdayTimeLabel, start: availabilityData.wednesdayStart, end: availabilityData.wednesdayEnd)
        }
        
        if availabilityData.thursdayAvailable != "0" {
            updateLabel(thursdayView, label: thursdayTimeLabel, start: availabilityData.thursdayStart, end: availabilityData.tuesdayEnd)
        }
        
        if availabilityData.fridayAvailable != "0" {
            updateLabel(fridayView, label: fridayTimeLabel, start: availabilityData.fridayStart, end: availabilityData.fridayEnd)
        }
        
        if availabilityData.saturdayAvailable != "0" {
            updateLabel(saturdayView, label: satTimeLabel, start: availabilityData.saturdayStart, end: availabilityData.saturdayEnd)
        }
        
        if availabilityData.sundayAvailable != "0" {
            updateLabel(sundayView, label: sunTimeLabel, start: availabilityData.sundayStart, end: availabilityData.sundayEnd)
        }
    }
    
    
    func updateLabel(dateView:UIView, label:UILabel, start:String, end:String) {
        
        dateView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
        
        let startDateObject = NSDate(fromString: "16 July 1972 \(start) ", format: .Custom("dd MMM yyyy HH:mm:ss"))
        
        let endDateObject = NSDate(fromString: "16 July 1972 \(end) ", format: .Custom("dd MMM yyyy HH:mm:ss"))
        
        
        let start = formatter.stringFromDate(startDateObject)
        
        let end = formatter.stringFromDate(endDateObject)
        
        let timeRange = "\(start) - \(end)"
        
        label.text = timeRange
    }
    
    @IBAction func cancelRequestBtnPressed(sender: UIButton) {
        
        if availabilityData.approved == "1" {
            self.navigationController?.popViewControllerAnimated(true)
        } else {
            
            let cancelRequestApi = AvailabilityModelList(id: id, employeeId: employeeId)
            
            cancelRequestApi.cancelAvailabilityHistory{ (responseObject, error) in
                
                if error == nil {
                    print("No Error \(responseObject)")
                    self.navigationController?.popViewControllerAnimated(true)
                } else {
                    print("Error: \(error)")
                }
            }
            
        }
    }
}
