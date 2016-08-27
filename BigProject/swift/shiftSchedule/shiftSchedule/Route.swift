//
//  Route.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-03-30.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import Foundation

//base URL
let baseURL = "https://app19.pushoperations.com/"

//login API URL endpoint
let LoginURL = baseURL + "api/v1/ios/login"

//get daily scheduler list of data API endpoint
let getDailySchedulerAPi = baseURL + "api/v1/ios/getDailyScheduler"

//get daily scheduler list of data API endpoint
let getDailySchedulerByDateAPi = baseURL + "api/v1/ios/getDailySchedulerByDate"

//get My Schedule List of data API endpoint
let getMySchedulerApi = baseURL + "api/v1/ios/getMyScheduler"

//get My Release
let getReleaseShiftApi = baseURL + "api/v1/ios/release"

//get my Swap Shift
let getMySwapShiftApi = baseURL + "api/v1/ios/swap"

//pick up shift
let pickUpshiftApi = baseURL + "payroll/pickup_shift"

//Cancel my release Shift
let cancelEmployeeReleaseApi = baseURL + "payroll/swap_shift_action"

//Cancel my swap shift (note: same with my release shift since once it cancel everything set to 0 at DB level)
let cancelEmployeeSwapApi = baseURL + "payroll/swap_shift_action"

//cancel shift
let cancelPickUpshiftApi = baseURL + "payroll/cancel_pickup_shift"

//mySchedule Swap Request
let requestMyscheduleShift = baseURL + "payroll/request_swap_shift"

//save Device Token Request
let deviceSaveApi = baseURL + "api/v1/pushnotifications/deviceToken"

//cancel Device Token Request
let deviceLogoutApi = baseURL + "/api/v1/pushnotifications/deleteDeviceToken"

//Availibity
let sendAvailability = baseURL + "/api/v1/ios/Availability"
let availabilityHistory = baseURL + "/api/v1/ios/getAvailabilityHistory"
let cancelPendingAvailability = baseURL + "/api/v1/ios/cancelAvailability"
let timeOffSubmit = baseURL + "/api/v1/ios/timeOff"
let timeOffCancel = baseURL + "/api/v1/ios/timeOffCancel"




