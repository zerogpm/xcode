//
//  SwapDetailVC.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-03-23.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit
import SwiftyJSON

class SwapDetailVC: UIViewController, UITextFieldDelegate{
    @IBOutlet weak var shiftText: UILabel!
    @IBOutlet weak var SwapReleaseSegment: UISegmentedControl!
    @IBOutlet weak var RequestButton: UIButton!
    @IBOutlet weak var commentBox: UITextField!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var timeRange: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    var mySchedule: MySchedule!
    var swappableTimes = [String]()
    var swappableIdLists = [Int]()
    var selectedSegmentIndex = 0
    var employeeId : String = ""
    var currentShift : String = ""
    var swapShiftId : String = ""
    var comments : String = ""
    
    @IBOutlet weak var inital: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        picker.dataSource = self
        picker.delegate = self
        commentBox.delegate = self
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let id = defaults.stringForKey(userId){
            self.employeeId = id
        }
        
        if let userF = defaults.stringForKey(userFirstName), let userL = defaults.stringForKey(userLastName) {
            let firstInitial = String(userF[userF.startIndex])
            let secondInitial = String(userL[userL.startIndex])
            inital.text = "\(firstInitial)\(secondInitial)"
        }
        
        SwapReleaseSegment.selectedSegmentIndex = 0
        
        for index in 0..<self.mySchedule.swappableTime.count {
            swappableTimes.append(String(self.mySchedule.swappableTime[index]))
        }
        
        for index in 0..<self.mySchedule.swappableId.count {
            swappableIdLists.append(Int(self.mySchedule.swappableId[index] as! NSNumber))
        }
        
        if swappableTimes.count == 0 {
            self.RequestButton.setTitle("Return", forState: UIControlState.Normal)
            self.RequestButton.backgroundColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
            shiftText.text = "No available shifts to swap"
            SwapReleaseSegment.hidden = true
            commentBox.hidden = true
            picker.hidden = true
        } else {
            self.swapShiftId = String(swappableIdLists[0])
        }
        
        
        //dump(Int(self.mySchedule.swappableId[0] as! NSNumber))
        //dump(String(self.mySchedule.swappableTime[0]))
        self.currentShift = mySchedule.scheduleId
        date.text = self.mySchedule.date
        timeRange.text = self.mySchedule.timeRange
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        commentBox.resignFirstResponder()
        return true
    }
    
    @IBAction func switchValueChange(sender: UISegmentedControl) {
        switch SwapReleaseSegment.selectedSegmentIndex
        {
        case 0:
            self.RequestButton.setTitle("Swap shift", forState: UIControlState.Normal)
            self.RequestButton.backgroundColor = UIColor(red: 0.5059, green: 0.7412, blue: 0.2549, alpha: 1.0)
            selectedSegmentIndex = 0
            picker.hidden = false
        case 1:
            self.RequestButton.setTitle("Release shift", forState: UIControlState.Normal)
            self.RequestButton.backgroundColor = UIColor(red: 243/255, green: 156/255, blue: 18/255, alpha: 1.0)
            selectedSegmentIndex = 1
            picker.hidden = true
        default:
            break;
        }
    }
    
    @IBAction func RequestButtonPress(sender: AnyObject) {
        
        if selectedSegmentIndex == 0 {
            
            if swappableTimes.count == 0 {
                let message = "Return to my schedule"
                self.showAlert("Success", msg: message)
            } else {
                if let commentText = commentBox.text where commentBox.text != "" {
                    networkRequest(commentText, actionType: MyScheduleSwap)
                } else {
                    showAlert("Error", msg: "Please fill in a comment")
                }
            }
        } else {
            if let commentText = commentBox.text where commentBox.text != "" {
                networkRequest(commentText, actionType: MyScheduleRelease)
            } else {
                showAlert("Error", msg: "Please fill the comment")
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
    
    func networkRequest(commentText:String, actionType:String) {
        
        var typeName = ""
        if actionType == MyScheduleSwap {
            typeName = "swap"
        } else {
            typeName = "release"
        }
        
        let myScheduleActionApi = MyScheduleActionModel(action: actionType, employeeId: self.employeeId, current_shift_id: self.currentShift, swap_shift_id: self.swapShiftId, comments: commentText)
        
        loader.startAnimating()
        
        myScheduleActionApi.myScheduleShiftSwap { (responseObject, error) in
            if error == nil {
                if let tempResponseObject = responseObject {
                    let response = JSON(tempResponseObject)
                    if response["status"] != "success" {
                        self.showAlert("Error", msg: "The \(typeName) shift is no longer availble")
                    } else {
                        let message = "You have successfully submitted a \(typeName) Request"
                        self.showAlert("Success", msg: message)
                    }
                    self.loader.stopAnimating()
                }
            } else {
                self.showAlert("Error", msg: "problem with your network")
            }
        }
    }
}

extension SwapDetailVC {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SwapDetailVC.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension SwapDetailVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        
        if swappableTimes.count == 0 {
            pickerLabel.textColor = UIColor.blackColor()
            pickerLabel.font = UIFont(name: "Helvetica Neue", size: 18)
            pickerLabel.text = "No available shifts to swap"
            pickerLabel.textAlignment = NSTextAlignment.Center
        } else {
            pickerLabel.textColor = UIColor.blackColor()
            pickerLabel.font = UIFont(name: "Helvetica Neue", size: 18)
            pickerLabel.text = swappableTimes[row]
            pickerLabel.textAlignment = NSTextAlignment.Center
        }
        
        return pickerLabel
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return swappableTimes.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let itemSelected = swappableIdLists[row]
        self.swapShiftId = String(itemSelected)
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return swappableTimes[row]
    }
}
