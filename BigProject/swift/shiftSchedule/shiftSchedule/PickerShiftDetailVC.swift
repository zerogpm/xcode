//
//  PickerShiftDetailVC.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-04-18.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit
import SwiftyJSON

class PickerShiftDetailVC: UIViewController {
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    @IBOutlet weak var fullName: UILabel!
    
    @IBOutlet weak var position: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var timeRange: UILabel!
    
    @IBOutlet weak var buttonOutlet: UIButton!
        
    @IBOutlet weak var initial: UILabel!
    var otherReleaseReuqest: OtherReleaseRequest!
    let defaults = NSUserDefaults.standardUserDefaults()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstInitialString = String(otherReleaseReuqest.fullName[otherReleaseReuqest.fullName.startIndex])
        
        if let rangOfEmptySpace = otherReleaseReuqest.fullName.rangeOfString(" ", options: NSStringCompareOptions.BackwardsSearch) {
            let suffix = String(otherReleaseReuqest.fullName.characters.suffixFrom(rangOfEmptySpace.endIndex))
            let secondInitialString = String(suffix[suffix.startIndex])
            initial.text = "\(firstInitialString)\(secondInitialString)"
        }
        
        fullName.text = otherReleaseReuqest.fullName
        position.text = otherReleaseReuqest.position
        date.text = otherReleaseReuqest.scheduledStart
        timeRange.text = otherReleaseReuqest.timeRange
        if otherReleaseReuqest.userChangeApproved == CancelShift {
            buttonOutlet.backgroundColor = UIColor(red: 231/255, green: 76/255, blue: 60/255, alpha: 1.0)
            buttonOutlet.setTitle("Cancel", forState: UIControlState.Normal)
        } else {
            buttonOutlet.backgroundColor = UIColor(red: 129/255, green: 189/255, blue: 65/255, alpha: 1.0)
            buttonOutlet.setTitle("Pick Up", forState: UIControlState.Normal)
        }
    }
    
    @IBAction func PickupButtonPressed(sender: AnyObject) {
        if let id = defaults.stringForKey(userId) {
            
            let shiftRquestApi = PickUpPostModel(userId:id, releaseId: otherReleaseReuqest.releaseId, userChangeApproved: otherReleaseReuqest.userChangeApproved)
            
            loader.startAnimating()
            
            shiftRquestApi.shiftRelease { (responseObject, error) in
                if error == nil {
                    if let tempResponseObject = responseObject {
                        let response = JSON(tempResponseObject)
                        if response["status"] != "success" {
                            self.showErrorAlert("Error", msg: "The shift is no longer here")
                        } else {
                            var message = ""
                            if self.otherReleaseReuqest.userChangeApproved == PickupShift {
                                message = "you successfully submitted your request to pickup the shift. Your manager will now review your request."
                            } else {
                                message = "You successfully cancelled the shift pick up."
                            }
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
