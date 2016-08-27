//
//  PendingCancelVC.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-04-28.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit
import SwiftyJSON

class PendingCancelVC: UIViewController {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var timeRange: UILabel!
    @IBOutlet weak var cancelButtonLabel: UIButton!
    var mySchedule: MySchedule!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var currentShiftId : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var initial: UILabel!
    
    override func viewDidAppear(animated: Bool) {
        
        self.currentShiftId = mySchedule.scheduleId
        self.date.text = "Pending for \(mySchedule.date)"
        self.timeRange.text = mySchedule.timeRange
        
        if mySchedule.status == PendingSwap {
            cancelButtonLabel.setTitle("Cancel Swap", forState: UIControlState.Normal)
        } else {
            cancelButtonLabel.setTitle("Cancel Release", forState: UIControlState.Normal)
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let userF = defaults.stringForKey(userFirstName), let userL = defaults.stringForKey(userLastName) {
            let firstInitial = String(userF[userF.startIndex])
            let secondInitial = String(userL[userL.startIndex])
            initial.text = "\(firstInitial)\(secondInitial)"
        }
    }
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        networkRequest()
    }
    
    func networkRequest() {
        
        let CancelActionApi = MyScheduleActionModel(action: "", employeeId: "", current_shift_id: self.currentShiftId, swap_shift_id: "", comments: "")
        
        loader.startAnimating()
        
        CancelActionApi.cancelAction { (responseObject, error) in
            if error == nil {
                if let tempResponseObject = responseObject {
                    let response = JSON(tempResponseObject)
                    if response["status"] != "success" {
                        self.showAlert("Error", msg: "The shift is no longer availble")
                    } else {
                        let message = "You Just successfully Cancel the Request"
                        self.showAlert("Success", msg: message)
                    }
                    self.loader.stopAnimating()
                }
            } else {
                self.showAlert("Error", msg: "problem with your network")
            }
        }
    }
    
    func showAlert(title:String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        
        if title == "Error" {
            let actionError = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            alert.addAction(actionError)
        } else {
            let actionPop = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction) -> Void in
                self.navigationController?.popViewControllerAnimated(true)
            })
            alert.addAction(actionPop)
        }
        presentViewController(alert, animated: true, completion:nil)
    }
    
}
