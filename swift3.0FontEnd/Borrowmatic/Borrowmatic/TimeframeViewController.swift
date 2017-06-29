//
//  TimeframeViewController.swift
//  Borrowmatic
//
//  Created by Brian Advent on 09/11/2016.
//  Copyright © 2016 Brian Advent. All rights reserved.
//

import UIKit



class TimeframeViewController: UIViewController, GLCalendarViewDelegate {

  @IBOutlet weak var calendarView: GLCalendarView!
    
    
    var timeFrame:GLCalendarDateRange? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        calendarView.delegate = self
        
        GLCalendarView.appearance().rowHeight = 54
        GLCalendarView.appearance().padding = 6
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let today = NSDate()
        let beginDate = GLDateUtils.date(byAddingDays: 0, to: today as Date!)
        let endDate = GLDateUtils.date(byAddingDays: 7, to: today as Date!)
        
        let range = GLCalendarDateRange(begin: beginDate, end: endDate)
        range?.backgroundColor = UIColor.lightGray
        range?.editable = true
        calendarView.ranges = [range!]
        
        calendarView.reload()
        
        DispatchQueue.main.async { 
            self.calendarView.scroll(to: self.calendarView.lastDate, animated: false)
        }
        
        

        
    }
    @IBAction func donePressed(_ sender: UIButton) {
        
        
        self.dismiss(animated: true, completion: nil)

    }

    func calenderView(_ calendarView: GLCalendarView!, canAddRangeWithBegin beginDate: Date!) -> Bool {
            return true
    }
    
    func calenderView(_ calendarView: GLCalendarView!, rangeToAddWithBegin beginDate: Date!) -> GLCalendarDateRange! {
        let endDate = GLDateUtils.date(byAddingDays: 0, to: beginDate)
        let range = GLCalendarDateRange(begin: beginDate, end: endDate)
        range?.backgroundColor = UIColor.lightGray
        range?.editable = true
        
        return range
        
    }
    
    func calenderView(_ calendarView: GLCalendarView!, canUpdate range: GLCalendarDateRange!, toBegin beginDate: Date!, end endDate: Date!) -> Bool {
        return true
    }
    
    func calenderView(_ calendarView: GLCalendarView!, beginToEdit range: GLCalendarDateRange!) {
        
    }
    
    func calenderView(_ calendarView: GLCalendarView!, finishEdit range: GLCalendarDateRange!, continueEditing: Bool) {
        
    }
    
    func calenderView(_ calendarView: GLCalendarView!, didUpdate range: GLCalendarDateRange!, toBegin beginDate: Date!, end endDate: Date!) {
        timeFrame = range
    }
    
    
    
    

}
