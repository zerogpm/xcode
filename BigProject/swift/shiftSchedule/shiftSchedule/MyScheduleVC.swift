//
//  MyScheduleVC.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-03-22.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit
import AFDateHelper

class MyScheduleVC: UIViewController, MyScheduleListDelegate {
    
    @IBOutlet weak var DateRange: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var revealMenu: UIBarButtonItem!
    @IBOutlet weak var myShiftTable: UITableView!
    
    var refreshControl = UIRefreshControl()
    var mySchedulesSection = [MyScheduleSection]()
    let model:MyScheduleListMode = MyScheduleListMode()
    
    var startingPoint : NSDate?
    var id = ""
    var mycompanyId = ""
    var defaultTime = NSDate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        loader.startAnimating()
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if let id = defaults.stringForKey(userId), myCompanyId = defaults.stringForKey(company_Id){
            if let daySession = defaults.objectForKey(dateSession) {
                let startOfTheWeek = daySession as! NSDate
                fetchingDays(startOfTheWeek, id: id, myCompanyId: myCompanyId)
            } else {
                let startOfTheWeek = NSDate()
                fetchingDays(startOfTheWeek, id: id, myCompanyId: myCompanyId)
            }
        }
        
        self.model.delegate = self
        myShiftTable.dataSource = self
        myShiftTable.delegate = self
        
        title = "My Schedule"
        
        self.refreshControl.addTarget(self, action: #selector(MyScheduleVC.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.myShiftTable.addSubview(refreshControl)
        
        let leftBarItemButton = UIButton()
        leftBarItemButton.frame = CGRectMake(0, 0, 30, 25)
        leftBarItemButton.setImage(UIImage(named: "menu"), forState: .Normal)
        leftBarItemButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), forControlEvents: .TouchUpInside)
        revealMenu.customView = leftBarItemButton
        
        let rightBarItemButton = UIButton()
        rightBarItemButton.frame = CGRectMake(0, 0, 25, 25)
        rightBarItemButton.setImage(UIImage(named: "Date"), forState: .Normal)
        rightBarItemButton.addTarget(self, action: #selector(MyScheduleVC.selectDate as (MyScheduleVC) -> () -> ()), forControlEvents: .TouchUpInside)
        navigationItem.rightBarButtonItem?.customView = rightBarItemButton
        
        self.view.addGestureRecognizer((self.revealViewController().panGestureRecognizer()))
    }
    
    func fetchingDays(days:NSDate, id:String, myCompanyId:String){
        let startOfTheWeek = days
        let endOfTheWeek = startOfTheWeek.dateByAddingDays(7)
        let startOfTheWeekString = startOfTheWeek.toString(format: .Custom("yyyy-MM-dd"))
        let endOfTheWeekString = endOfTheWeek.toString(format: .Custom("yyyy-MM-dd"))
        DateRange.text = "\(startOfTheWeekString) to \(endOfTheWeekString)"
        self.id = String(id)
        self.mycompanyId = myCompanyId
        self.model.getMyScheduleList(String(id), myComanyId: myCompanyId, date: startOfTheWeekString)
    }
    
    @IBAction func nextSevenDayTap(sender: UIButton) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let daySession = defaults.objectForKey(dateSession){
            let startOfTheWeek = daySession as! NSDate
            let next7Days = startOfTheWeek.dateByAddingDays(7)
            
            NSUserDefaults.standardUserDefaults().setObject(next7Days, forKey: dateSession)
            NSUserDefaults.standardUserDefaults().synchronize()
            
            let startOfTheWeekString = next7Days.toString(format: .Custom("yyyy-MM-dd"))
            
            self.loader.startAnimating()
            self.model.getMyScheduleList(self.id, myComanyId: self.mycompanyId, date: startOfTheWeekString)
            self.myShiftTable.reloadData()
        }
    }
    
    @IBAction func previousSevenDayTap(sender: UIButton) {
    
        let defaults = NSUserDefaults.standardUserDefaults()
        if let daySession = defaults.objectForKey(dateSession) {
            let startOfTheWeek = daySession as! NSDate
            let pre7Days = startOfTheWeek.dateBySubtractingDays(7)
            
            NSUserDefaults.standardUserDefaults().setObject(pre7Days, forKey: dateSession)
            NSUserDefaults.standardUserDefaults().synchronize()
            
            let startOfTheWeekString = pre7Days.toString(format: .Custom("yyyy-MM-dd"))
            
            
            self.loader.startAnimating()
            self.model.getMyScheduleList(self.id, myComanyId: self.mycompanyId, date: startOfTheWeekString)
            self.myShiftTable.reloadData()
        }
    }
    

    func selectDate() {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        DatePickerDialog().show("Pick a Date", doneButtonTitle: "Done",cancelButtonTitle: "Cancel", defaultDate: defaultTime, datePickerMode: .Date) {
            (date) -> Void in
            
            NSUserDefaults.standardUserDefaults().setObject(date, forKey: dateSession)
            NSUserDefaults.standardUserDefaults().synchronize()
            
            let startOfTheWeekString = date.toString(format: .Custom("yyyy-MM-dd"))
            self.defaultTime = date
            
            self.loader.startAnimating()
            if let id = defaults.stringForKey(userId), myCompanyId = defaults.stringForKey(company_Id)  {
                self.model.getMyScheduleList(String(id), myComanyId: myCompanyId, date: startOfTheWeekString)
                self.myShiftTable.reloadData()
            }
        }
    }
    
    func dataReady() {
        self.mySchedulesSection = self.model.section
        self.DateRange.text = self.model.dateRang
        self.myShiftTable.reloadData()
        loader.stopAnimating()
    }
    
    func refresh(sender:AnyObject) {
        if self.refreshControl.refreshing
        {
            self.refreshControl.endRefreshing()
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let daySession = defaults.objectForKey(dateSession) {
            let startOfTheWeek = daySession as! NSDate
            let endOfTheWeek = startOfTheWeek.dateByAddingDays(7)
            let startOfTheWeekString = startOfTheWeek.toString(format: .Custom("yyyy-MM-dd"))
            let endOfTheWeekString = endOfTheWeek.toString(format: .Custom("yyyy-MM-dd"))
            DateRange.text = "\(startOfTheWeekString) to \(endOfTheWeekString)"
            
            self.model.getMyScheduleList(self.id, myComanyId: self.mycompanyId, date: startOfTheWeekString)
            self.myShiftTable.reloadData()
        } else {
            let startOfTheWeek = NSDate()
            let endOfTheWeek = startOfTheWeek.dateAtEndOfWeek()
            let startOfTheWeekString = startOfTheWeek.toString(format: .Custom("yyyy-MM-dd"))
            let endOfTheWeekString = endOfTheWeek.toString(format: .Custom("yyyy-MM-dd"))
            DateRange.text = "\(startOfTheWeekString) to \(endOfTheWeekString)"
            
            self.model.getMyScheduleList(self.id, myComanyId: self.mycompanyId, date: startOfTheWeekString)
            self.myShiftTable.reloadData()
        }
    }
}

extension MyScheduleVC: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        var numberOfSections = 0
        
        if self.mySchedulesSection.count > 0 {
            tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            numberOfSections = mySchedulesSection.count
            myShiftTable.backgroundView = nil
        } else {
            let noData = UILabel(frame: CGRectMake(0, 0, myShiftTable.bounds.size.width, myShiftTable.bounds.size.height))
            noData.text = "No Data available, Pick another Date"
            noData.font = UIFont(name: "HelveticaNeue", size: 12.0)
            noData.textColor = UIColor.blackColor()
            noData.textAlignment = NSTextAlignment.Center;
            myShiftTable.backgroundView = noData
            myShiftTable.separatorStyle = UITableViewCellSeparatorStyle.None
        }
        
        return numberOfSections
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mySchedulesSection[section].mySchedules.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("MySchedule") as? MyScheduleCell {
            let mySchedule = mySchedulesSection[indexPath.section].mySchedules[indexPath.row]
            cell.configureCell(mySchedule)
            return cell
        } else {
            let cell = MyScheduleCell()
            return cell
        }
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        //header.contentView.backgroundColor = UIColor(red: 128/255, green: 189/255, blue: 1/255, alpha: 1.0)
        header.textLabel!.font = UIFont(name: "SFCompactText-Regular", size: 14.0)
        header.textLabel!.textColor = UIColor(red: 155/255, green: 155/255, blue: 155/255, alpha: 1.0)
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        let mySchedule = mySchedulesSection[indexPath.section].mySchedules[indexPath.row]
        
        if(mySchedule.status == Editable) {
            return indexPath
        }
        
        if(mySchedule.status == PendingSwap) {
            return indexPath
        }
        
        if(mySchedule.status == PedningRelease) {
            return indexPath
        }
        
        return nil;
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let title = mySchedulesSection[section].heading
        return title
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let mySchedule = mySchedulesSection[indexPath.section].mySchedules[indexPath.row]
        
        if mySchedule.status == Editable {
            performSegueWithIdentifier("swapDetails", sender: mySchedule)
        } else {
            performSegueWithIdentifier("PendingCancel", sender: mySchedule)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "swapDetails" {
            if let swapDetailVC = segue.destinationViewController as? SwapDetailVC {
                if let mySchedule = sender as? MySchedule {
                    swapDetailVC.mySchedule = mySchedule
                }
            }
        } else if segue.identifier == "PendingCancel" {
            if let PendingCancelVC = segue.destinationViewController as? PendingCancelVC {
                if let mySchedule = sender as? MySchedule {
                    PendingCancelVC.mySchedule = mySchedule
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 91.0
    }
}

