//
//  ViewController.swift
//  PickerDate
//
//  Created by Jian Su on 2016-02-11.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var datePicker:UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker.center = view.center
        view.addSubview(datePicker)
        
        datePicker.addTarget(self, action: "datePickerChanged:", forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func datePickerChanged(sender: UIDatePicker) {
        print("Select date is: \(sender.date)")
    }
    
    @IBAction func selectDate(sender: UIButton) {
    }
    
    @IBAction func defaultDate(sender: UIButton) {
        datePicker.datePickerMode = UIDatePickerMode.DateAndTime
    }
    
    @IBAction func MinAndMax(sender: UIButton) {
        datePicker.datePickerMode = UIDatePickerMode.Date
        let oneYear: NSTimeInterval = 365 * 24 * 60 * 60
        let today = NSDate()
        let oneYearFromToday = today.dateByAddingTimeInterval(oneYear)
        let twoYearFromToday = today.dateByAddingTimeInterval(oneYear * 2)
        
        datePicker.minimumDate = oneYearFromToday
        datePicker.maximumDate = twoYearFromToday
    }
    
    @IBAction func CountDown(sender: UIButton) {
        datePicker.datePickerMode = UIDatePickerMode.CountDownTimer
        let threeMinues = (3 * 60) as NSTimeInterval
        datePicker.countDownDuration = threeMinues
    }
    
}

