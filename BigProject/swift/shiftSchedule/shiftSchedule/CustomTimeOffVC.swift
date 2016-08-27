//
//  CustomTimeOffVC.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-07-07.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit
import SwiftyJSON

class CustomTimeOffVC: UIViewController {
    
    @IBOutlet weak var endDateView: UIView!
    @IBOutlet weak var startDateView: UIView!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var date: UILabel!
    var dateFormat = ""
    
    var  startDefaultTime = NSDate(fromString: "12:00", format: .Custom("HH:mm"))
    var  endDefaultTime = NSDate(fromString: "12:00", format: .Custom("HH:mm"))
    var dateNS = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetup()
    }
    
    func initSetup() {
        startTime.text = "12:00AM"
        endTime.text = "12:00AM"
        date.text = ""
        tapGestureRecognizer()
    }
    
    func tapGestureRecognizer() {
        let dateTap = UITapGestureRecognizer(target: self, action: #selector(CustomTimeOffVC.handleDateTap(_:)))
        dateView.addGestureRecognizer(dateTap)
        
        let startDateTap = UITapGestureRecognizer(target: self, action: #selector(CustomTimeOffVC.handleStartDateTap(_:)))
        startDateView.addGestureRecognizer(startDateTap)
        
        let endDateTap = UITapGestureRecognizer(target: self, action: #selector(CustomTimeOffVC.handleEndDateTap(_:)))
        endDateView.addGestureRecognizer(endDateTap)
    }
    
    func handleDateTap(sender: UIView) {
        
        DatePickerDialog().show("Pick a Date", doneButtonTitle: "Done",cancelButtonTitle: "Cancel", defaultDate: dateNS, datePickerMode: .Date) {
            (date) -> Void in
            self.date.text = date.toString(format: .Custom("EEE, MMM d yyyy"))
            self.dateFormat = date.toString(format: .Custom("yyyy-MM-dd"))
            self.dateNS = date
        }
    }
    
    func handleStartDateTap(sender: UIView) {
        DatePickerDialog().show("Pick Start Date", doneButtonTitle: "Done",cancelButtonTitle: "Cancel", defaultDate: startDefaultTime, datePickerMode: .Time) {
            (date) -> Void in
            self.startTime.text = date.toString(format: .Custom("h:mma"))
            self.startDefaultTime = date
        }
    }
    
    func handleEndDateTap(sender: UIView) {
        DatePickerDialog().show("Pick End Date", doneButtonTitle: "Done",cancelButtonTitle: "Cancel", defaultDate: endDefaultTime, datePickerMode: .Time) {
            (date) -> Void in
            self.endTime.text = date.toString(format: .Custom("h:mma"))
            self.endDefaultTime = date
        }
    }
    
    @IBAction func dateBtnPressed(sender: UIButton) {
        
        DatePickerDialog().show("Pick a Date", doneButtonTitle: "Done",cancelButtonTitle: "Cancel",defaultDate: dateNS ,datePickerMode: .Date) {
            (date) -> Void in
            self.date.text = date.toString(format: .Custom("EEE, MMM d yyyy"))
            self.dateFormat = date.toString(format: .Custom("yyyy-MM-dd"))
            self.dateNS = date
        }
        
    }
    
    @IBAction func startBtnPressed(sender: UIButton) {
        
        DatePickerDialog().show("Pick Start Date", doneButtonTitle: "Done",cancelButtonTitle: "Cancel", defaultDate: startDefaultTime, datePickerMode: .Time) {
            (date) -> Void in
            self.startTime.text = date.toString(format: .Custom("h:mma"))
            self.startDefaultTime = date
        }
        
    }
    
    @IBAction func endTimePressed(sender: UIButton) {
        
        DatePickerDialog().show("Pick End Date", doneButtonTitle: "Done",cancelButtonTitle: "Cancel", defaultDate: endDefaultTime, datePickerMode: .Time) {
            (date) -> Void in
            self.endTime.text = date.toString(format: .Custom("h:mm a"))
            self.endDefaultTime = date
        }
        
    }
    
    @IBAction func submitBtnPressed(sender: UIButton) {
        
        if let startTime = startTime.text, endTime = endTime.text {
            
            if startTime == "00:00" || endTime == "00:00" || dateFormat == "" {
                showErrorAlert("Error", msg: "Date, Start and End Time are required")
            } else {
                
                let defaults = NSUserDefaults.standardUserDefaults()
                guard let myCompanyId = defaults.stringForKey(company_Id) else { print("problem with companyId"); return}
                guard let myId = defaults.stringForKey(userId) else {print("problem with userId"); return}
                
                let customTimeOff = timeOffModel(startDate: startTime, endDate: endTime, customDate: dateFormat, userId: myId, companyId: myCompanyId, availabilityType: "availability")
                
                customTimeOff.submitCustomTime({ (responseObject, error) in
                    
                    if error == nil {
                        
                        guard let unwarpResponse = responseObject else {print("response problem"); return}
                        
                        let response = JSON(unwarpResponse)
                        if response["status"] == "Success" {
                            self.performSegueWithIdentifier("showCustomList", sender: nil)
                        } else {
                            print("network not working")
                        }
                        
                        
                    } else {
                        print("Request Error: \(error)")
                    }
                    
                })
                
            }
            
        }
    }
    
    func showErrorAlert(title:String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion:nil)
    }
    
}
