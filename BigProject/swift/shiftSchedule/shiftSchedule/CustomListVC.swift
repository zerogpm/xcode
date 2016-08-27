//
//  CustomListVC.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-07-08.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit

class CustomListVC: UIViewController, timeOffModelListDelegate {
    
    @IBOutlet weak var customDateTable: UITableView!
    var customTimeOffList = [TimeOff]()
    let model:timeOffModelList = timeOffModelList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        guard let id = defaults.stringForKey(userId) else {print("no session id"); return}
        guard let companyId = defaults.stringForKey(company_Id) else {print("no company session id"); return}
        self.model.delegate = self
        customDateTable.dataSource = self
        customDateTable.delegate = self
        model.getTimeOffList(id, companyId: companyId, availabilityType: "availability")
    }

    func dataReady() {
        customTimeOffList = model.timeOffList
        customDateTable.reloadData()
    }
    
}

extension CustomListVC: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberOfSections = 1
        return numberOfSections
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customTimeOffList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let customTimeOff = customTimeOffList[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("customTimeOffCell") as? CustomTimeOffCell {
            cell.configureCell(customTimeOff)
            return cell
        } else {
            let cell = CustomTimeOffCell()
            return cell
        }
    }
    
}

extension CustomListVC: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let customTimeOffListData = customTimeOffList[indexPath.row]
        performSegueWithIdentifier("showCustomDetail", sender: customTimeOffListData)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showCustomDetail" {
            if let customOffDetail = segue.destinationViewController as? CustomDetailVC {
                if let TimeOffDetailData = sender as? TimeOff {
                    customOffDetail.customTimeOff = TimeOffDetailData
                }
            }
        }
    }
    
}