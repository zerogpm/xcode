//
//  CancelShiftVC.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-04-19.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit

class CancelShiftVC: UIViewController, EmployeeReleaseModelDelegate {
    @IBOutlet weak var cancelShiftTable: UITableView!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var employeeReleaseList = [EmployeeReleaseRequest]()
    let model:EmployeeReleaseModel = EmployeeReleaseModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader.startAnimating()
        let defaults = NSUserDefaults.standardUserDefaults()
        if let id = defaults.stringForKey(userId), myCompanyId = defaults.stringForKey(company_Id) {
            model.getEmployeeReleaseRequest(String(id),myCompanyId: String(myCompanyId))
        }
        self.model.delegate = self
        cancelShiftTable.dataSource = self
        
        title = "Cancel My Shift Releases"
    }

    func dataReady() {
        self.employeeReleaseList = self.model.employeeReleaseRequestList
        self.cancelShiftTable.reloadData()
        loader.stopAnimating()
    }
    @IBAction func goBack(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

extension CancelShiftVC: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberOfSections = 1
        
        if self.employeeReleaseList.count > 0 {
            tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            cancelShiftTable.backgroundView = nil
        } else {
            let noData = UILabel(frame: CGRectMake(0, 0, cancelShiftTable.bounds.size.width, cancelShiftTable.bounds.size.height))
            noData.text = "You don't have any shift releases at the moment"
            noData.font = UIFont(name: "HelveticaNeue", size: 14.0)
            noData.numberOfLines = 1
            noData.minimumScaleFactor = 2.0
            noData.allowsDefaultTighteningForTruncation = false
            noData.adjustsFontSizeToFitWidth = true
            noData.textColor = UIColor.blackColor()
            noData.textAlignment = NSTextAlignment.Center;
            cancelShiftTable.backgroundView = noData
            cancelShiftTable.separatorStyle = UITableViewCellSeparatorStyle.None
        }
        
        return numberOfSections
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeReleaseList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let employeeCancelShift = employeeReleaseList[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("cancelShift") as? CancelShiftCell {
            cell.configureCell(employeeCancelShift)
            return cell
        } else {
            let cell = CancelShiftCell()
            cell.configureCell(employeeCancelShift)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let employeeCancelShift = employeeReleaseList[indexPath.row]
            self.model.deleteMyShiftRelease(employeeCancelShift.releaseId)
            employeeReleaseList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 91.0
    }
    
}
