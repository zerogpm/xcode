//
//  NSdateCalculations.swift
//  
//
//  Created by Jian Su on 2016-02-08.
//
//

import Foundation
import UIKit

let userCalendar = NSCalendar.currentCalendar()

//create valentinesDay from Date Components
let valentinesDayComponents = NSDateComponents()
valentinesDayComponents.year = 2016
valentinesDayComponents.month = 2
valentinesDayComponents.day = 14
let valentesDay = userCalendar.dateFromComponents(valentinesDayComponents)

//create chinese dates object from a string
let dateMakerFormatter = NSDateFormatter()
dateMakerFormatter.calendar = userCalendar
dateMakerFormatter.dateFormat = "yyyy-MM-dd"
let chineseNewYear = dateMakerFormatter.dateFromString("2016-02-08")

valentesDay?.earlierDate(chineseNewYear!)
valentesDay?.laterDate(chineseNewYear!)

let dayOrder = valentesDay!.compare(chineseNewYear!)

//figure out day order
if dayOrder == .OrderedAscending {
    print("Valentine's Day Come before Chinese new Year!")
} else if dayOrder == .OrderedDescending {
    print("Valentine's Day Come After Chinese new Year")
} else if dayOrder == .OrderedSame {
    print("They are same Day")
}else {
    print("Impossible")
}

//figure out how many day between 2 holidays
valentesDay?.timeIntervalSinceDate(chineseNewYear!)
let dayCalendarUnit: NSCalendarUnit = [.Day]
let chineseDayValentinesDayDiffer = userCalendar.components(dayCalendarUnit, fromDate: chineseNewYear!, toDate: valentesDay!, options: [])

chineseDayValentinesDayDiffer.day

//How many hours and minutes bewtween 10:45 a.m and 12:00 noon?
dateMakerFormatter.dateFormat = "yyyy/MM/dd hh:mm a z"
let startTime = dateMakerFormatter.dateFromString("2016/01/27 10:45 AM -05:00")
let endTime = dateMakerFormatter.dateFromString("2016/01/27 12:00 PM -05:00")

let hourMinuteComponents: NSCalendarUnit = [.Hour, .Minute]
let MinutesDiff = userCalendar.components(hourMinuteComponents, fromDate: startTime!, toDate: endTime!, options: [])
MinutesDiff.hour
MinutesDiff.minute

//Date addition and subtraction next 10 days
let tenDaysFromNow = userCalendar.dateByAddingUnit([.Day], value: 10, toDate: NSDate(), options: [])

/** figure out what weekday (Sunday through Saturday) will it be ten
days from now
and which weekday of month will it be -- the 1st, 2nd? **/

let tenDaysFromNowComponents = userCalendar.components([.Weekday, .WeekdayOrdinal], fromDate: tenDaysFromNow!)
tenDaysFromNowComponents.weekday
tenDaysFromNowComponents.weekdayOrdinal

/**
Here’s another calculation: what was the date and time 3 days, 10 hours, 42 minutes, and 5 seconds ago? We’re doing date arithmetic with more than one kind of unit — days, hours, minutes, and seconds — so we need NSCalendar‘s dateByAddingComponents method instead:
**/
let periodComponents = NSDateComponents()
periodComponents.day = -3
periodComponents.hour = -10
periodComponents.minute = -42
periodComponents.second = -5
let TimeAgo = userCalendar.dateByAddingComponents(periodComponents, toDate: NSDate(), options: [])