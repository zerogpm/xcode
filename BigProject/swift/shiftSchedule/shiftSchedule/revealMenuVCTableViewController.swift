//
//  revealMenuVCTableViewController.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-05-18.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit

class revealMenuVCTableViewController: UITableViewController {
    
    var employeeId = ""
    
    @IBOutlet var revealMenuTable: UITableView!
    let menuList = ["My Schedule", "Daily Schedule", "Shift Swaps", "Shift Releases","Location", "Availability", "Time Off" ,"Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = NSUserDefaults.standardUserDefaults()
        if let id = defaults.stringForKey(userId){
            self.employeeId = id
        }
        revealMenuTable.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return menuList.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let menu = menuList[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("revealMenuCell") as? reavealMenuCell {
            cell.configureCell(menu, indexPathIndex: indexPath.row)
            cell.selectionStyle = .None;
            cell.backgroundColor = UIColor.clearColor()
            revealMenuTable.backgroundColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1.0)
            revealMenuTable.separatorStyle = .None
            return cell
        } else {
            let cell = reavealMenuCell()
            cell.configureCell(menu, indexPathIndex: indexPath.row)
            cell.backgroundColor = UIColor.clearColor()
            revealMenuTable.backgroundColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1.0)
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40.0
    }
    
    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.backgroundColor = UIColor(red: 35/255, green: 31/255, blue: 32/255, alpha: 1.0)
        }
    }
    
    override func tableView(tableView: UITableView, didUnhighlightRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.backgroundColor = UIColor(red: 74/255, green: 74/255, blue: 74/255, alpha: 1.0)
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        switch indexPath.row {
        case 0:
            self.performSegueWithIdentifier("mySchedule", sender: nil)
        case 1:
            self.performSegueWithIdentifier("dailyScheudle", sender: nil)
        case 2:
            self.performSegueWithIdentifier("myShiftSwaps", sender: nil)
        case 3:
            self.performSegueWithIdentifier("pickupShiftRelease", sender: nil)
        case 4:
            self.performSegueWithIdentifier("switchLocation", sender: nil)
        case 5:
            self.performSegueWithIdentifier("availability", sender: nil)
        case 6:
            self.performSegueWithIdentifier("timeOff", sender: nil)
        case 7:
            let removeDeviceToken = logoutActionModel(employeeId: self.employeeId)
            removeDeviceToken.deleteDeviceToken { (responseObject, error) in
                if error == nil {
                    dump(responseObject)
                } else {
                    dump(error)
                }
            }
            NSUserDefaults.standardUserDefaults().removeObjectForKey(userId)
            NSUserDefaults.standardUserDefaults().removeObjectForKey(company_Id)
            NSUserDefaults.standardUserDefaults().removeObjectForKey(myUserIdArray)
            NSUserDefaults.standardUserDefaults().removeObjectForKey(myCompanyIdArray)
            NSUserDefaults.standardUserDefaults().removeObjectForKey(dateSession)
            NSUserDefaults.standardUserDefaults().removeObjectForKey(userFirstName)
            NSUserDefaults.standardUserDefaults().removeObjectForKey(userLastName)
            self.dismissViewControllerAnimated(true, completion: nil)
        default:
            return
        }
    }
}

