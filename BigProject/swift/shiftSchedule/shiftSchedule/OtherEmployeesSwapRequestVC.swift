//
//  OtherEmployeesSwapRequestVC.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-04-20.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit

class OtherEmployeesSwapRequestVC: UIViewController, OtherShiftSwapModelDelegate {

    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var OtherEmployeesSwap: UITableView!
    var OtherShiftSwapList = [OtherShiftSwap]()
    let model:OtherShiftSwapModel = OtherShiftSwapModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        loader.startAnimating()
        let defaults = NSUserDefaults.standardUserDefaults()
        if let id = defaults.stringForKey(userId), myCompanyId = defaults.stringForKey(company_Id) {
            model.getOtherEmployeeSwap(String(id),myCompanyId: String(myCompanyId))
        }
        
        self.model.delegate = self
        OtherEmployeesSwap.dataSource = self
        OtherEmployeesSwap.delegate = self
        
        title = "Go to other people request"
    }
    
    @IBAction func goBack(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func dataReady() {
        self.OtherShiftSwapList = self.model.otherReleaseRequest
        self.OtherEmployeesSwap.reloadData()
        loader.stopAnimating()
    }
}

extension OtherEmployeesSwapRequestVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberOfSections = 1
        
        if self.OtherShiftSwapList.count > 0 {
            tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            OtherEmployeesSwap.backgroundView = nil
        } else {
            let noData = UILabel(frame: CGRectMake(0, 0, OtherEmployeesSwap.bounds.size.width, OtherEmployeesSwap.bounds.size.height))
            noData.font = UIFont(name: "HelveticaNeue", size: 14.0)
            noData.text = "You do not have any swap requests right now."
            noData.textColor = UIColor.blackColor()
            noData.textAlignment = NSTextAlignment.Center;
            OtherEmployeesSwap.backgroundView = noData
            OtherEmployeesSwap.separatorStyle = UITableViewCellSeparatorStyle.None
        }
        
        return numberOfSections
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return OtherShiftSwapList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let otherShiftSwap = OtherShiftSwapList[indexPath.row]
        if let cell = tableView.dequeueReusableCellWithIdentifier("OtherSwap") as? OtherSwapCell {
            cell.configureCell(otherShiftSwap)
            return cell
        } else {
            let cell = OtherSwapCell()
            cell.configureCell(otherShiftSwap)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let otherShiftSwap = OtherShiftSwapList[indexPath.row]
        performSegueWithIdentifier("OtherEmployeeSwap", sender: otherShiftSwap)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "OtherEmployeeSwap" {
            if let OtherEmployeesSwapDetailVC = segue.destinationViewController as? OtherEmployeesSwapDetailVC {
                if let otherPeopleSwap = sender as? OtherShiftSwap {
                    OtherEmployeesSwapDetailVC.otherSwapReuqest = otherPeopleSwap
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        let otherShiftSwap = OtherShiftSwapList[indexPath.row]
        
        if(otherShiftSwap.shiftStatus == "Pending User Approval.") {
            return indexPath
        }
        
        return nil;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 228.0
    }
    
}