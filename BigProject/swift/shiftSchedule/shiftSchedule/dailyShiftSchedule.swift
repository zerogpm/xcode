//
//  dailyShiftSchedule.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-03-21.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class dailyShiftSchedule: UIViewController, DailyShiftModelDelegate{
    
    let searchController = UISearchController(searchResultsController: nil)
    var dailyShifts = [DailyShift]()
    var filteredDailyShifts = [DailyShift]()
    let dateMakerFormatter = NSDateFormatter()
    let model:DailyShiftModel = DailyShiftModel()
    var myUserId = ""
    var myCompanyId:String = ""
    var deviceId : String = ""
    var deviceTokenUserId : String = ""
    var refreshControl = UIRefreshControl()
    
    @IBOutlet weak var dateBarItem: UIBarButtonItem!
    @IBOutlet weak var revealMenu: UIBarButtonItem!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var dailyShiftTableView: UITableView!
    var defaultTime = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        title = "Daily Schedule"
        
        self.refreshControl.addTarget(self, action: #selector(dailyShiftSchedule.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.dailyShiftTableView.addSubview(refreshControl)
        
        
        let rightBarItemButton = UIButton()
        rightBarItemButton.frame = CGRectMake(0, 0, 25, 25)
        rightBarItemButton.setImage(UIImage(named: "Date"), forState: .Normal)
        rightBarItemButton.addTarget(self, action: #selector(dailyShiftSchedule.selectDate as (dailyShiftSchedule) -> () -> ()), forControlEvents: .TouchUpInside)
        dateBarItem.customView = rightBarItemButton
        
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let deviceToken = delegate.deviceId
        self.deviceId = deviceToken
        
        //scope bar
        searchController.searchBar.scopeButtonTitles = ["Employee", "Position","Time"]
        searchController.searchBar.delegate = self
        
        //search bar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.barStyle = UIBarStyle.BlackTranslucent
        searchController.searchBar.tintColor = UIColor.whiteColor()
        dailyShiftTableView.tableHeaderView = searchController.searchBar
        
        loader.startAnimating()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let myCompanyId = defaults.stringForKey(company_Id), let myUserId = defaults.stringForKey(userId), let deviceUserId = defaults.stringForKey(mydeviceUserId) {
            self.myCompanyId = myCompanyId
            self.myUserId = myUserId
            self.deviceTokenUserId = deviceUserId
            model.getDailySchedulerList(String(myCompanyId))
        }
        
        sendDeviceToken()
        
        self.model.delegate = self
        
        let leftBarItemButton = UIButton()
        leftBarItemButton.frame = CGRectMake(0, 0, 30, 25)
        leftBarItemButton.setImage(UIImage(named: "menu"), forState: .Normal)
        leftBarItemButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), forControlEvents: .TouchUpInside)
        revealMenu.customView = leftBarItemButton
        self.view.addGestureRecognizer((self.revealViewController().panGestureRecognizer()))
        
        dailyShiftTableView.dataSource = self
    }
    
    func dataReady() {
        self.dailyShifts = self.model.dailyShiftList
        self.dailyShiftTableView.reloadData()
        loader.stopAnimating()
    }
    
    func refresh(sender:AnyObject) {
        if self.refreshControl.refreshing
        {
            self.refreshControl.endRefreshing()
        }
        model.getDailySchedulerList(String(myCompanyId))
        self.dailyShiftTableView.reloadData()
    }
    
    func sendDeviceToken() {
        
        let deviceTokenRequest = DeviceTokenModel(userId: self.deviceTokenUserId, deviceToken: self.deviceId)
        
        deviceTokenRequest.saveDeviceToken { (responseObject, error) in
            
            if error == nil {
                if let tempResponseObject = responseObject {
                    let response = JSON(tempResponseObject)
                    if(response["status"] != "success") {
                        print(response["reason"])
                    } else {
                        print(response["reason"])
                    }
                }
            } else {
                print(error)
            }
        }

    }
    
    func selectDate() {
        DatePickerDialog().show("Pick a Date", doneButtonTitle: "Done",cancelButtonTitle: "Cancel", defaultDate: defaultTime, datePickerMode: .Date) {
            (date) -> Void in
            self.dateMakerFormatter.dateFormat = "yyyy-MM-dd"
            let FormattedDate = self.dateMakerFormatter.stringFromDate(date)
            self.defaultTime = date
            self.loader.startAnimating()
            self.model.getDailySchedulerByDateList(FormattedDate, myCompanyId: self.myCompanyId)
            self.dailyShiftTableView.reloadData()
        }
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "Employee") {
        filteredDailyShifts = dailyShifts.filter { employee in
            
            if scope == "Time" {
                return employee.timeRange.lowercaseString.containsString(searchText.lowercaseString)
            }
            
            if scope == "Position" {
                return employee.position.lowercaseString.containsString(searchText.lowercaseString)
            }
            
            return employee.fullName.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        dailyShiftTableView.reloadData()
    }
}

extension dailyShiftSchedule: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        var numberOfSections = 0
        
        if self.dailyShifts.count > 0 {
            tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            numberOfSections = 1
            dailyShiftTableView.backgroundView = nil
        } else {
            let noData = UILabel(frame: CGRectMake(0, 0, dailyShiftTableView.bounds.size.width, dailyShiftTableView.bounds.size.height))
            noData.text = "No Data available, Pick another Date"
            noData.font = UIFont(name: "HelveticaNeue", size: 14.0)
            noData.textColor = UIColor.blackColor()
            noData.textAlignment = NSTextAlignment.Center;
            dailyShiftTableView.backgroundView = noData
            dailyShiftTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        }
        
        return numberOfSections
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredDailyShifts.count
        }
        return dailyShifts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var dailyShift: DailyShift
        if searchController.active && searchController.searchBar.text != "" {
            dailyShift = filteredDailyShifts[indexPath.row]
        } else {
            dailyShift = dailyShifts[indexPath.row]
        }
        
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("dailyCell") as? DailyShiftCell {
            cell.configureCell(dailyShift)
            return cell
        } else {
            let cell = DailyShiftCell()
            cell.configureCell(dailyShift)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 147.0
    }
}

extension dailyShiftSchedule: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension dailyShiftSchedule: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
