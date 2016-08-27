//
//  timeOffListVC.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-07-05.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit

class timeOffListVC: UIViewController, timeOffModelListDelegate{

    @IBOutlet weak var timeOffTable: UITableView!
    var timeOffList = [TimeOff]()
    let model:timeOffModelList = timeOffModelList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        guard let id = defaults.stringForKey(userId) else {print("no session id"); return}
        guard let companyId = defaults.stringForKey(company_Id) else {print("no company session id"); return}
        self.model.delegate = self
        timeOffTable.dataSource = self
        timeOffTable.delegate = self
        model.getTimeOffList(id, companyId: companyId, availabilityType: "off")
    }
    
    func dataReady() {
        timeOffList = model.timeOffList
        timeOffTable.reloadData()
    }
}

extension timeOffListVC: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberOfSections = 1
        
        if self.timeOffList.count > 0 {
            tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            timeOffTable.backgroundView = nil
        } else {
            let noData = UILabel(frame: CGRectMake(0, 0, timeOffTable.bounds.size.width, timeOffTable.bounds.size.height))
            noData.text = "you don't have any Time Off data right now"
            noData.font = UIFont(name: "HelveticaNeue", size: 12.0)
            noData.textColor = UIColor.blackColor()
            noData.textAlignment = NSTextAlignment.Center;
            timeOffTable.backgroundView = noData
            timeOffTable.separatorStyle = UITableViewCellSeparatorStyle.None
        }
        
        return numberOfSections
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeOffList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let timeOff = timeOffList[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("timeOffCell") as? TimeOffCell {
            cell.configureCell(timeOff)
            return cell
        } else {
            let cell = TimeOffCell()
            return cell
        }
    }
    
}

extension timeOffListVC: UITableViewDelegate {
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let timeOffListData = timeOffList[indexPath.row]
        performSegueWithIdentifier("showTimeOffDetails", sender: timeOffListData)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showTimeOffDetails" {
            if let TimeOffDetail = segue.destinationViewController as? TimeOffCancelDetails {
                if let TimeOffDetailData = sender as? TimeOff {
                    TimeOffDetail.timeOffData = TimeOffDetailData
                }
            }
        }
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100.0
    }
    
}