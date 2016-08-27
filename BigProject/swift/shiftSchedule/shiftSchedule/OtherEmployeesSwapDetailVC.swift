//
//  OtherEmployeesSwapDetailVC.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-04-20.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit
import SwiftyJSON

class OtherEmployeesSwapDetailVC: UIViewController {
    @IBOutlet weak var myScheduledStart: UILabel!
    @IBOutlet weak var myTimeRange: UILabel!

    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var swapPersonTimeRange: UILabel!
    @IBOutlet weak var swapPerosnScheduledStart: UILabel!
    @IBOutlet weak var swapPersonFullName: UILabel!
    var otherSwapReuqest: OtherShiftSwap!
    
    @IBOutlet weak var initial: UILabel!
    
    @IBOutlet weak var swapInitial: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Other Perople Swap Request"
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let userF = defaults.stringForKey(userFirstName), let userL = defaults.stringForKey(userLastName) {
            let userFString = String(userF[userF.startIndex])
            let userLString = String(userL[userL.startIndex])
            initial.text = "\(userFString)\(userLString)"
        }
        
        let swapFString = String(otherSwapReuqest.swapPersonFullName[otherSwapReuqest.swapPersonFullName.startIndex])
        
        if let rangOfEmptySpace = otherSwapReuqest.swapPersonFullName.rangeOfString(" ", options: NSStringCompareOptions.BackwardsSearch) {
            let suffix = String(otherSwapReuqest.swapPersonFullName.characters.suffixFrom(rangOfEmptySpace.endIndex))
            let swapLString = String(suffix[suffix.startIndex])
            swapInitial.text = "\(swapFString)\(swapLString)"
        }
        
        myScheduledStart.text = otherSwapReuqest.myScheduledStart
        myTimeRange.text = otherSwapReuqest.myTimeRange
        swapPersonTimeRange.text = otherSwapReuqest.swapPersonTimeRange
        swapPerosnScheduledStart.text = otherSwapReuqest.swapPerosnScheduledStart
        swapPersonFullName.text = otherSwapReuqest.swapPersonFullName
    }
    
    @IBAction func accpetButtonPressed(sender: UIButton) {
        let otherSwapRquestApi = OtherSwapDetailsModel(currentShiftId: otherSwapReuqest.releaseID, action: Accpet)
        loader.startAnimating()
        otherSwapRquestApi.shiftSwap { (responseObject, error) in
            if error == nil {
                if let tempResponseObject = responseObject {
                    let response = JSON(tempResponseObject)
                    if response["status"] != "success" {
                        self.showErrorAlert("Error", msg: "The swap is no longer here")
                    } else {
                        let message = "You successfully accepted the shift swap request. Your manager will now review your request."
                        self.showErrorAlert("Success", msg: message)
                    }
                    self.loader.stopAnimating()
                }
            } else {
                print(error)
                self.showErrorAlert("Error", msg: "problem with your network")
                self.loader.stopAnimating()
            }
        }
    }
    
    @IBAction func declineButtonPress(sender: UIButton) {
        let otherSwapRquestApi = OtherSwapDetailsModel(currentShiftId: otherSwapReuqest.releaseID, action: Reject)
        loader.startAnimating()
        otherSwapRquestApi.shiftSwap { (responseObject, error) in
            if error == nil {
                if let tempResponseObject = responseObject {
                    let response = JSON(tempResponseObject)
                    if response["status"] != "success" {
                        self.showErrorAlert("Error", msg: "The swap is no longer here")
                    } else {
                        let message = "You Just successfully Decline a swap Request"
                        self.showErrorAlert("Success", msg: message)
                    }
                    self.loader.stopAnimating()
                }
            } else {
                self.showErrorAlert("Error", msg: "problem with your network")
                self.loader.stopAnimating()
            }
        }

    }
    
    func showErrorAlert(title:String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction) -> Void in
            self.navigationController?.popViewControllerAnimated(true)
        })
        alert.addAction(action)
        presentViewController(alert, animated: true, completion:nil)
    }
}
