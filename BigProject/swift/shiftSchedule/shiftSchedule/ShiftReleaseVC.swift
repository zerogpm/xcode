//
//  ShiftReleaseVC.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-03-28.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit

class ShiftReleaseVC: UIViewController, ShiftReleaseModelDelegate{
    
    var otherPeopleReleaseList = [OtherReleaseRequest]()
    let model:ShiftReleaseModel = ShiftReleaseModel()
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    @IBOutlet weak var revealMenu: UIBarButtonItem!

    @IBOutlet weak var shiftReleaseTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        loader.startAnimating()
        let defaults = NSUserDefaults.standardUserDefaults()
        if let id = defaults.stringForKey(userId), myCompanyId = defaults.stringForKey(company_Id) {
            model.getMyShiftRelease(String(id),myCompanyId: String(myCompanyId))
        }
        
        shiftReleaseTable.dataSource = self
        shiftReleaseTable.delegate = self
        self.model.delegate = self
        
        title = "Pick Up Shift Releases"
        let leftBarItemButton = UIButton()
        leftBarItemButton.frame = CGRectMake(0, 0, 30, 25)
        leftBarItemButton.setImage(UIImage(named: "menu"), forState: .Normal)
        leftBarItemButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), forControlEvents: .TouchUpInside)
        revealMenu.customView = leftBarItemButton
        self.view.addGestureRecognizer((self.revealViewController().panGestureRecognizer()))

    }
    
    func dataReady() {
        self.otherPeopleReleaseList = self.model.otherReleaseRequest
        self.shiftReleaseTable.reloadData()
        loader.stopAnimating()
    }
    
}

extension ShiftReleaseVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberOfSections = 1
        
        if self.otherPeopleReleaseList.count > 0 {
            tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
            shiftReleaseTable.backgroundView = nil
        } else {
            let noData = UILabel(frame: CGRectMake(0, 0, shiftReleaseTable.bounds.size.width, shiftReleaseTable.bounds.size.height))
            noData.text = "There are no shifts to pick up"
            noData.font = UIFont(name: "HelveticaNeue", size: 14.0)
            noData.textColor = UIColor.blackColor()
            noData.textAlignment = NSTextAlignment.Center;
            shiftReleaseTable.backgroundView = noData
            shiftReleaseTable.separatorStyle = UITableViewCellSeparatorStyle.None
        }
        
        return numberOfSections
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return otherPeopleReleaseList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("ShiftRelease") as? ShiftReleaseCell {
            cell.configureCell(otherPeopleReleaseList[indexPath.row])
            return cell
        } else {
            let cell = ShiftReleaseCell()
            cell.configureCell(otherPeopleReleaseList[indexPath.row])
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let otherPeopleRelease = otherPeopleReleaseList[indexPath.row]
        performSegueWithIdentifier("pickUpDetails", sender: otherPeopleRelease)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "pickUpDetails" {
            if let PickerShiftDetailVC = segue.destinationViewController as? PickerShiftDetailVC {
                if let otherPeopleRelease = sender as? OtherReleaseRequest {
                    PickerShiftDetailVC.otherReleaseReuqest = otherPeopleRelease
                }
            }
        }
    }

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 137.0
    }
    
}
