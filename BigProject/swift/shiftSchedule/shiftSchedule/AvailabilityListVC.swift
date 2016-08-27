//
//  AvailabilityListVC.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-06-29.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit

class AvailabilityListVC: UIViewController, AvailabilityModelDelegate {
    
    var availabilityList = [AvailabilityHistory]()
    let model:AvailabilityModelList = AvailabilityModelList()
    var id = ""
    var refreshControl = UIRefreshControl()
    
    @IBOutlet weak var availabilityListTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        guard let myUserId = defaults.stringForKey(userId) else {print("Cannot get session userID"); return}
        id = myUserId
        
        self.refreshControl.addTarget(self, action: #selector(AvailabilityListVC.refresh(_:)), forControlEvents: UIControlEvents.ValueChanged)
        self.availabilityListTable.addSubview(refreshControl)
        
        availabilityListTable.delegate = self
        availabilityListTable.dataSource = self
        self.model.delegate = self
        model.getAvailabilityHistory(myUserId)

    }
    
    func refresh(sender:AnyObject) {
        if self.refreshControl.refreshing
        {
            self.refreshControl.endRefreshing()
        }
        model.getAvailabilityHistory(id)
        self.availabilityListTable.reloadData()
    }
    
    func dataReady() {
        self.availabilityList = self.model.availabilityData
        self.availabilityListTable.reloadData()
    }

}

extension AvailabilityListVC: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return availabilityList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let availabilityData = availabilityList[indexPath.row]

        if let cell = tableView.dequeueReusableCellWithIdentifier("availabilityCell") as? AvailabilityCell {
            cell.configureCell(availabilityData)
            return cell
        } else {
            let cell = AvailabilityCell()
            return cell
        }
        
    }
    
}

extension AvailabilityListVC: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let availabilityListData = availabilityList[indexPath.row]
        performSegueWithIdentifier("availabilityDetail", sender: availabilityListData)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "availabilityDetail" {
            if let availabilityDetail = segue.destinationViewController as? AvailabilityDetailVC {
                if let availabilityListData = sender as? AvailabilityHistory {
                    availabilityDetail.availabilityData = availabilityListData
                }
            }
        }
    }
    
}