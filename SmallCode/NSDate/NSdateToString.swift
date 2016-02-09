//
//  NSdate.swift
//  
//
//  Created by Jian Su on 2016-02-08.
//
//

import Foundation
import UIKit

let userCalendar = NSCalendar.currentCalendar()

let firstLandPhone = NSDateComponents()

firstLandPhone.year = 1802
firstLandPhone.month = 2
firstLandPhone.day = 7
//firstLandPhone.weekday = 1
//firstLandPhone.weekdayOrdinal = 1
firstLandPhone.timeZone = NSTimeZone(name:"Asia/Hong_Kong")

let now = NSDate()

let firstLandPhoneCallDate = userCalendar.dateFromComponents(firstLandPhone)!
print(firstLandPhoneCallDate)

let pacificCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
pacificCalendar.timeZone = NSTimeZone(name: "US/Pacific")!

let HongKongCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
HongKongCalendar.timeZone = NSTimeZone(name: "Asia/Hong_Kong")!

let requestedDateComponents: NSCalendarUnit = [.Year, .Month, .Day, .Hour, .Minute]

let HongKongComponents = HongKongCalendar.components(requestedDateComponents, fromDate: now)

HongKongComponents.year
HongKongComponents.month
HongKongComponents.day
HongKongComponents.hour
HongKongComponents.minute

//convert NSDate into String
let formatter = NSDateFormatter()
formatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
formatter.dateFormat = "yyyy-MM-dd"
formatter.stringFromDate(now)

//conver String into NSDate
formatter.dateFormat = "yyyy-MM-dd"
formatter.dateFromString("2014-05-04")