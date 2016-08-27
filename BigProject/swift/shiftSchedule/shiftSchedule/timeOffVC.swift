//
//  timeOffVC.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-07-05.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit
import AFDateHelper
import SwiftyJSON

class timeOffVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var startDateLabel: UILabel!

    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var startDateView: UIView!
    
    @IBOutlet weak var endDateView: UIView!
    @IBOutlet weak var reasonTextField: UITextField!
    
    var startNSObject = NSDate()
    var endNSObject = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initSetup()
    }
    
    func initSetup() {
        title = "Time Off"
        self.hideKeyboardWhenTappedAround()
        startDateLabel.text = ""
        endDateLabel.text = ""
        reasonTextField.delegate = self
        tapGestureRecognizer()
        let revealMenu = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: nil)
        navigationItem.leftBarButtonItem = revealMenu
        
        let leftBarItemButton = UIButton()
        leftBarItemButton.frame = CGRectMake(0, 0, 30, 25)
        leftBarItemButton.setImage(UIImage(named: "menu"), forState: .Normal)
        leftBarItemButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), forControlEvents: .TouchUpInside)
        revealMenu.customView = leftBarItemButton
        self.view.addGestureRecognizer((self.revealViewController().panGestureRecognizer()))
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        reasonTextField.resignFirstResponder()
        return true
    }
    
    func tapGestureRecognizer() {
        let startTap = UITapGestureRecognizer(target: self, action: #selector(timeOffVC.handleStartDateTap(_:)))
        startDateView.addGestureRecognizer(startTap)
        
        let endTap = UITapGestureRecognizer(target: self, action: #selector(timeOffVC.handleEndDateTap(_:)))
        endDateView.addGestureRecognizer(endTap)
    }
    
    func handleStartDateTap(sender: UIView) {
        
        DatePickerDialog().show("Pick Start Time", doneButtonTitle: "Done",cancelButtonTitle: "Cancel", datePickerMode: .Date) {
            (date) -> Void in
            self.startNSObject = date
            self.updateTimeUI(date, label: self.startDateLabel)
        }
    }
    
    func handleEndDateTap(sender: UIView) {
        DatePickerDialog().show("Pick End Time", doneButtonTitle: "Done",cancelButtonTitle: "Cancel", datePickerMode: .Date) {
            (date) -> Void in
            self.endNSObject = date
            self.updateTimeUI(date, label: self.endDateLabel)
        }
    }
    
    @IBAction func startBtnPressed(sender: UIButton) {
        DatePickerDialog().show("Pick Start Time", doneButtonTitle: "Done",cancelButtonTitle: "Cancel", datePickerMode: .Date) {
            (date) -> Void in
            self.startNSObject = date
            self.updateTimeUI(date, label: self.startDateLabel)
        }
    }
    
    @IBAction func endButtonPressed(sender: UIButton) {
        DatePickerDialog().show("Pick End Time", doneButtonTitle: "Done",cancelButtonTitle: "Cancel", datePickerMode: .Date) {
            (date) -> Void in
            self.endNSObject = date
            self.updateTimeUI(date, label: self.endDateLabel)
        }
    }
    
    func updateTimeUI(date:NSDate, label:UILabel){
        let year = date.year()
        let day = date.day()
        let weekday = date.weekdayToString()
        let month = date.monthToString()
        label.text = "\(weekday), \(month) \(day) \(year)"
    }
    
    @IBAction func submitbtnPressed(sender: UIButton) {
        
        if let startDate = startDateLabel.text, endDate = endDateLabel.text, reason = reasonTextField.text {
            
            if startDate == "" || endDate == "" || reason == "" {
                
                showErrorAlert("Warning", msg: "Dates and Reason are required")
                
            } else {
                guard let reason = reasonTextField.text else {print("problem with reason"); return}
                let defaults = NSUserDefaults.standardUserDefaults()
                guard let myCompanyId = defaults.stringForKey(company_Id) else { print("problem with companyId"); return}
                guard let myId = defaults.stringForKey(userId) else {print("problem with userId"); return}
                
                let startDate = startNSObject.toString(format: .ISO8601(ISO8601Format.Date))
                let endDate = endNSObject.toString(format: .ISO8601(ISO8601Format.Date))
                
                let timeOffSubmit = AvailabilityModel(startDate: startDate, endDate: endDate, reason: reason, userId: myId, companyId: myCompanyId)
                timeOffSubmit.submitTimeOff { (responseObject, error) in
                    
                    if error == nil {
                        
                        guard let unwarpResponse = responseObject else {print("response problem"); return}
                        let response = JSON(unwarpResponse)
                        
                        if response["status"] == "Success" {
                            self.performSegueWithIdentifier("showTimeOffList", sender: nil)
                        } else {
                            print(response["status"])
                        }
                        
                    } else {
                        print("Request Error: \(error)")
                    }
                }
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

extension timeOffVC {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(timeOffVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
