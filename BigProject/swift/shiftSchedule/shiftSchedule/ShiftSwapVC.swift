//
//  ShiftSwapVC.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-03-24.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit

class ShiftSwapVC: UIViewController, EmployeeSwapModelDelegate {
    
    var shiftSwapList = [shiftSwap]()
    let model:EmployeeSwapModel = EmployeeSwapModel()
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var revealMenu: UIBarButtonItem!

    @IBOutlet weak var shifSwapTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loader.startAnimating()
        let defaults = NSUserDefaults.standardUserDefaults()
        if let id = defaults.stringForKey(userId), myCompanyId = defaults.stringForKey(company_Id) {
            model.getEmployeeSwapRequest(String(id),myCompanyId: String(myCompanyId))
        }
        self.model.delegate = self
        
        shifSwapTable.dataSource = self
        shifSwapTable.delegate = self
        
        title = "My Shift Swaps"
        let leftBarItemButton = UIButton()
        leftBarItemButton.frame = CGRectMake(0, 0, 30, 25)
        leftBarItemButton.setImage(UIImage(named: "menu"), forState: .Normal)
        leftBarItemButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), forControlEvents: .TouchUpInside)
        revealMenu.customView = leftBarItemButton
        self.view.addGestureRecognizer((self.revealViewController().panGestureRecognizer()))
    }
    
    func dataReady() {
        self.shiftSwapList = self.model.employeeSwapRequestList
        self.shifSwapTable.reloadData()
        loader.stopAnimating()
    }
}

extension ShiftSwapVC: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberOfSections = 1
        
        if self.shiftSwapList.count > 0 {
            tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            shifSwapTable.backgroundView = nil
        } else {
            let noData = UILabel(frame: CGRectMake(0, 0, shifSwapTable.bounds.size.width, shifSwapTable.bounds.size.height))
            noData.text = "You do not have any swap requests right now."
            noData.font = UIFont(name: "HelveticaNeue", size: 14.0)
            noData.textColor = UIColor.blackColor()
            noData.textAlignment = NSTextAlignment.Center;
            //shifSwapTable.backgroundView = UIImageView(image: UIImage(named: "SampleImage"))
            shifSwapTable.backgroundView = noData
            shifSwapTable.separatorStyle = UITableViewCellSeparatorStyle.None
        }
        
        return numberOfSections
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shiftSwapList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let shiftSwap = shiftSwapList[indexPath.row]
        shifSwapTable.separatorStyle = .None
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("shiftSwaps") as? shiftSwapCell {
            cell.configureCell(shiftSwap)
            return cell
        } else {
            let cell = shiftSwapCell()
            cell.configureCell(shiftSwap)
            return cell
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let employeeCancelSwap = shiftSwapList[indexPath.row]
            self.model.deleteMySwap(employeeCancelSwap.releaseID)
            shiftSwapList.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 228.0
    }

}

extension ShiftSwapVC: UITableViewDelegate {
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "Cancel"
    }
}
