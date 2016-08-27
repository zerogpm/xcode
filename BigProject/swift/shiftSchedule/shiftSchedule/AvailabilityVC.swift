//
//  AvailabilityVC.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-06-21.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit
import AFDateHelper
import SwiftyJSON

class AvailabilityVC: UIViewController {
    
    @IBOutlet weak var MondayOutlet: UIButton!
    @IBOutlet weak var TuesdayOutlet: UIButton!
    @IBOutlet weak var WednesdayOutlet: UIButton!
    @IBOutlet weak var ThursdayOutlet: UIButton!
    @IBOutlet weak var FridayOutlet: UIButton!
    @IBOutlet weak var SaturdayOutlet: UIButton!
    @IBOutlet weak var SundayOutlet: UIButton!
    
    @IBOutlet weak var effectiveDateSelected: UILabel!
    
    @IBOutlet weak var numberOfDays: UILabel!
    
    @IBOutlet weak var startTime: UILabel!
    
    @IBOutlet weak var endTime: UILabel!
    
    @IBOutlet weak var availableView: UIView!
    
    @IBOutlet weak var availableCheckImage: UIImageView!
    
    @IBOutlet weak var availiabilitySubmitBtn: UIButton!
    
    @IBOutlet weak var numberOfDaysView: UIView!
    
    @IBOutlet weak var effectiveStartDateView: UIView!
    
    @IBOutlet weak var weeklyRequestHistoryView: UIView!
    @IBOutlet weak var startTimeView: UIView!
    
    @IBOutlet weak var endTimeView: UIView!
    var myCompanyId = ""
    var myUserId = ""
    
    var monday = Weekday(weekdayName: "monday",available: 0,startTime: "12:00AM",endTime: "12:00AM")
    var tuesday = Weekday(weekdayName: "tuesday",available: 0,startTime: "12:00AM",endTime: "12:00AM")
    var wednesday = Weekday(weekdayName: "wednesday",available: 0,startTime: "12:00AM",endTime: "12:00AM")
    var thursday = Weekday(weekdayName: "thursday",available: 0,startTime: "12:00AM",endTime: "12:00AM")
    var firday = Weekday(weekdayName: "friday",available: 0,startTime: "12:00AM",endTime: "12:00AM")
    var saturday = Weekday(weekdayName: "saturday",available: 0,startTime: "12:00AM",endTime: "12:00AM")
    var sunday = Weekday(weekdayName: "sunday",available: 0,startTime: "12:00AM",endTime: "12:00AM")
    
    var weekDays = [Weekday]()
    
    var selectedDay = 0;
    
    var startDefaultTime = NSDate(fromString: "12:00", format: .Custom("HH:mm"))
    var endDefaultTime = NSDate(fromString: "12:00", format: .Custom("HH:mm"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        effectiveDateSelected.text = "0000-00-00"
        weekDays.append(monday)
        weekDays.append(tuesday)
        weekDays.append(wednesday)
        weekDays.append(thursday)
        weekDays.append(firday)
        weekDays.append(saturday)
        weekDays.append(sunday)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let myCompanyId = defaults.stringForKey(company_Id), myUserId = defaults.stringForKey(userId) {
            self.myCompanyId = myCompanyId
            self.myUserId = myUserId
        }
        
        tapGestureRecognizer()
        
        startTime.text = weekDays[selectedDay].startTime
        endTime.text = weekDays[selectedDay].endTime
        
        self.MondayOutlet.backgroundColor = UIColor(red: 35/255, green: 31/255, blue: 32/255, alpha: 1.0)
        self.TuesdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
        self.WednesdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
        self.ThursdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
        self.FridayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
        self.SaturdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
        self.SundayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
        
        let revealMenu = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: nil)
        navigationItem.leftBarButtonItem = revealMenu
        title = "Availability"
        let leftBarItemButton = UIButton()
        leftBarItemButton.frame = CGRectMake(0, 0, 30, 25)
        leftBarItemButton.setImage(UIImage(named: "menu"), forState: .Normal)
        leftBarItemButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), forControlEvents: .TouchUpInside)
        revealMenu.customView = leftBarItemButton
        self.view.addGestureRecognizer((self.revealViewController().panGestureRecognizer()))
    }
    
    func tapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(AvailabilityVC.handleTap(_:)))
        availableView.addGestureRecognizer(tap)
        
        let viewTapNumberOfDays = UITapGestureRecognizer(target: self, action: #selector(AvailabilityVC.handleNumberOfDaysViewTap(_:)))
        numberOfDaysView.addGestureRecognizer(viewTapNumberOfDays)
        
        let viewTapEffectiveDays = UITapGestureRecognizer(target: self, action: #selector(AvailabilityVC.handleEffectiveDaysViewTap(_:)))
        effectiveStartDateView.addGestureRecognizer(viewTapEffectiveDays)
        
        let viewTapHistroy = UITapGestureRecognizer(target: self, action: #selector(AvailabilityVC.handleHistory(_:)))
        weeklyRequestHistoryView.addGestureRecognizer(viewTapHistroy)
        
        let startTimeViewTap = UITapGestureRecognizer(target: self, action: #selector(AvailabilityVC.handleStartTimeViewTap(_:)))
        startTimeView.addGestureRecognizer(startTimeViewTap)
        
        let endTimeViewTap = UITapGestureRecognizer(target: self, action: #selector(AvailabilityVC.handleEndTimeViewTap(_:)))
        endTimeView.addGestureRecognizer(endTimeViewTap)
    }
    
    func handleTap(sender: UIView) {
        
        if weekDays[selectedDay].available == 1 {
            availableCheckImage.hidden = true
            weekDays[selectedDay].available = 0
        } else {
            availableCheckImage.hidden = false
            weekDays[selectedDay].available = 1
        }
        
    }
    
    func handleNumberOfDaysViewTap(sender: UIView) {
        performSegueWithIdentifier("showNumberOfDays", sender: nil)
    }
    
    func handleEffectiveDaysViewTap(sender:UIView) {
        performSegueWithIdentifier("showEffectiveDate", sender: nil)
    }
    
    func handleHistory(sender:UIView) {
        performSegueWithIdentifier("requestHistroy", sender: nil)
    }
    
    func handleStartTimeViewTap(sender:UIView) {
        
        DatePickerDialog().show("Pick Start Time", doneButtonTitle: "Done",cancelButtonTitle: "Cancel", defaultDate: startDefaultTime, datePickerMode: .Time) {
            (date) -> Void in
            self.startTime.text = date.toString(format: .Custom("h:mma"))
            self.startDefaultTime = date
            self.weekDays[self.selectedDay].startTime = self.startTime.text!
        }
    }
    
    func handleEndTimeViewTap(sender:UIView) {
        DatePickerDialog().show("Pick End Time", doneButtonTitle: "Done",cancelButtonTitle: "Cancel", defaultDate: endDefaultTime, datePickerMode: .Time) {
            (date) -> Void in
            self.endTime.text = date.toString(format: .Custom("h:mma"))
            self.endDefaultTime = date
            self.weekDays[self.selectedDay].endTime = self.endTime.text!
        }
    }
    
    func myHandler(alert:UIAlertAction!) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    @IBAction func availabilityHistoryBtnPressed(sender: UIButton) {
        performSegueWithIdentifier("requestHistroy", sender: nil)
    }
    
    @IBAction func startTimePressed(sender: UIButton) {
        DatePickerDialog().show("Pick Start Time", doneButtonTitle: "Done",cancelButtonTitle: "Cancel", defaultDate: startDefaultTime, datePickerMode: .Time) {
            (date) -> Void in
            self.startTime.text = date.toString(format: .Custom("h:mma"))
            self.startDefaultTime = date
            self.weekDays[self.selectedDay].startTime = self.startTime.text!
        }
    }
    
    @IBAction func endTimePressed(sender: UIButton) {
        DatePickerDialog().show("Pick End Time", doneButtonTitle: "Done",cancelButtonTitle: "Cancel", defaultDate: endDefaultTime, datePickerMode: .Time) {
            (date) -> Void in
            self.endTime.text = date.toString(format: .Custom("h:mma"))
            self.endDefaultTime = date
            self.weekDays[self.selectedDay].endTime = self.endTime.text!
        }
    }
    
    @IBAction func weekDaysButtonPressed(sender: UIButton) {
        
        switch sender.tag {
        case 0:
            changingBackgroundColor(sender.tag)
            updateWeekDaysUI(sender.tag)
        case 1:
            changingBackgroundColor(sender.tag)
            updateWeekDaysUI(sender.tag)
        case 2:
            changingBackgroundColor(sender.tag)
            updateWeekDaysUI(sender.tag)
        case 3:
            changingBackgroundColor(sender.tag)
            updateWeekDaysUI(sender.tag)
        case 4:
            changingBackgroundColor(sender.tag)
            updateWeekDaysUI(sender.tag)
        case 5:
            changingBackgroundColor(sender.tag)
            updateWeekDaysUI(sender.tag)
        case 6:
            changingBackgroundColor(sender.tag)
            updateWeekDaysUI(sender.tag)
        default:
            return
        }
    }
    
    func updateWeekDaysUI(sender:Int) {
        selectedDay = sender
        
        if weekDays[selectedDay].available == 1 {
            availableCheckImage.hidden = false
        } else {
            availableCheckImage.hidden = true
        }
        startTime.text = weekDays[selectedDay].startTime
        endTime.text = weekDays[selectedDay].endTime
        let startNS = NSDate(fromString: weekDays[selectedDay].startTime, format: .Custom("h:mma"))
        let endNS = NSDate(fromString: weekDays[selectedDay].endTime, format: .Custom("h:mma"))
        startDefaultTime = startNS
        endDefaultTime = endNS
    }
    
    @IBAction func SubmitButtonPressed(sender: UIButton) {
    
        guard let numbersOfDay = numberOfDays.text else{ print("Empty number of days"); return }
        guard let effectiveStartDate = effectiveDateSelected.text else{ print("Empty effectiveDateSelected of days"); return }
        
        if weekDays[0].available == 0 && weekDays[1].available == 0 && weekDays[2].available == 0 && weekDays[3].available == 0 && weekDays[4].available == 0 && weekDays[5].available == 0 && weekDays[6].available == 0 {
            showErrorAlert("Warning", msg: "You must select at least one day to be available")
        } else if numbersOfDay == "0" {
            showErrorAlert("Warning", msg: "you at least to pick one day to work")
        } else if effectiveStartDate == "0000-00-00"{
            showErrorAlert("Warning", msg: "you at least to pick 1 Effective Start Date")
        } else {
            let availability = AvailabilityModel(userId: myUserId, companyId: myCompanyId, weekDays: weekDays, numberOfDays: numbersOfDay, effectiveStartDate: effectiveStartDate)
            
            availability.submitAvailability {
                (responseObject, error) in
                
                if error == nil {
                    if let TempResponseObject = responseObject {
                        let response = JSON(TempResponseObject)
                        self.performSegueWithIdentifier("requestHistroy", sender: nil)
                        print(response)
                    }
                } else {
                    print(error)
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showEffectiveDate" {
            if let AvailabilityTimeSelect = segue.destinationViewController as? AvailabilityTimeSelect {
                AvailabilityTimeSelect.delegate = self
            }
        } else if segue.identifier == "showNumberOfDays" {
            if let numberOfDayPickerVC = segue.destinationViewController as? numberOfDayPickerVC {
                numberOfDayPickerVC.delegate = self
            }
        }
    }
    
    func changingBackgroundColor(day:Int) {
        
        switch day {
        case 0:
            self.MondayOutlet.backgroundColor = UIColor(red: 35/255, green: 31/255, blue: 32/255, alpha: 1.0)
            self.TuesdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.WednesdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.ThursdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.FridayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.SaturdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.SundayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
        case 1:
            self.MondayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.TuesdayOutlet.backgroundColor = UIColor(red: 35/255, green: 31/255, blue: 32/255, alpha: 1.0)
            self.WednesdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.ThursdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.FridayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.SaturdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.SundayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
        case 2:
            self.MondayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.TuesdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.WednesdayOutlet.backgroundColor = UIColor(red: 35/255, green: 31/255, blue: 32/255, alpha: 1.0)
            self.ThursdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.FridayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.SaturdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.SundayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
        case 3:
            self.MondayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.TuesdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.WednesdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.ThursdayOutlet.backgroundColor = UIColor(red: 35/255, green: 31/255, blue: 32/255, alpha: 1.0)
            self.FridayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.SaturdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.SundayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
        case 4:
            self.MondayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.TuesdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.WednesdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.ThursdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.FridayOutlet.backgroundColor = UIColor(red: 35/255, green: 31/255, blue: 32/255, alpha: 1.0)
            self.SaturdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.SundayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
        case 5:
            self.MondayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.TuesdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.WednesdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.ThursdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.FridayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.SaturdayOutlet.backgroundColor = UIColor(red: 35/255, green: 31/255, blue: 32/255, alpha: 1.0)
            self.SundayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
        case 6:
            self.MondayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.TuesdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.WednesdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.ThursdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.FridayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.SaturdayOutlet.backgroundColor = UIColor(red: 57/255, green: 57/255, blue: 57/255, alpha: 1.0)
            self.SundayOutlet.backgroundColor = UIColor(red: 35/255, green: 31/255, blue: 32/255, alpha: 1.0)
        default:
            return
        }
        
        
    }
}

extension AvailabilityVC:numberOfDayPickerDelegate,EffectiveDateEnteredDelegate {
    
    func userPickedDateInfo(selectedDate:NSDate) {
        effectiveDateSelected.text = selectedDate.toString(format: .ISO8601(ISO8601Format.Date))
    }
    
    func pickDay(Days: String) {
        numberOfDays.text = Days
    }
}

