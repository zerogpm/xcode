//
//  SettingVC.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-05-10.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit

class SettingVC: UIViewController {
    
    var companyArray = [String]()
    var userIdArray = [String]()
    var companyNameArray = [String]()
    var companyStartTimeArray = [String]()
    
    var selectedUserId : String = ""
    var companyId : String = ""
    var companyName : String = ""
    var companyStartDate : String = ""
    
    @IBOutlet weak var picker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.dataSource = self
        picker.delegate = self
        
        let revealMenu = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: nil)
        navigationItem.leftBarButtonItem = revealMenu
        title = "Setting"
        let leftBarItemButton = UIButton()
        leftBarItemButton.frame = CGRectMake(0, 0, 30, 25)
        leftBarItemButton.setImage(UIImage(named: "menu"), forState: .Normal)
        leftBarItemButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), forControlEvents: .TouchUpInside)
        revealMenu.customView = leftBarItemButton
        self.view.addGestureRecognizer((self.revealViewController().panGestureRecognizer()))
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let companyArray = defaults.objectForKey(myCompanyIdArray), userIdArray = defaults.objectForKey(myUserIdArray), companyNameArray = defaults.objectForKey(myCompanyNameArray), companyStartDateArray = defaults.objectForKey(companyStartDateArray) {
            self.companyArray = companyArray as! [String]
            self.userIdArray = userIdArray as! [String]
            self.companyNameArray = companyNameArray as! [String]
            self.companyStartTimeArray = companyStartDateArray as! [String]
            self.selectedUserId = self.userIdArray[0]
            self.companyId = self.companyArray[0]
            self.companyName = self.companyNameArray[0]
            self.companyStartDate = self.companyStartTimeArray[0]
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let row = defaults.integerForKey("pickerIndex")
        picker.selectRow(row, inComponent: 0, animated: true)
    }
    
    @IBAction func switchButtonPress(sender: UIButton) {
        //Don't use the same name as userId for value. use selectedUserId. Otherwise won't work.self doesn't work either.
        NSUserDefaults.standardUserDefaults().setValue(self.selectedUserId, forKey: userId)
        NSUserDefaults.standardUserDefaults().setValue(self.companyId, forKey: company_Id)
        
        let startDateNsDate = NSDate(fromString:  companyStartDate, format: .ISO8601(nil))
        NSUserDefaults.standardUserDefaults().setObject(startDateNsDate, forKey: dateSession)
        NSUserDefaults.standardUserDefaults().synchronize()
        
        showAlert("switch", msg: "You have successfully switched to \(self.companyName)")
    }
    
    func showAlert(title:String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        
        if title == "switch" {
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

extension SettingVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.blackColor()
        pickerLabel.font = UIFont(name: "Helvetica Neue", size: 18)
        pickerLabel.text = self.companyNameArray[row]
        pickerLabel.textAlignment = NSTextAlignment.Center
        return pickerLabel
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return companyNameArray.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.companyId = companyArray[row]
        self.selectedUserId = userIdArray[row]
        self.companyName = companyNameArray[row]
        self.companyStartDate = companyStartTimeArray[row]
        
        NSUserDefaults.standardUserDefaults().setValue(row, forKey: "pickerIndex")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return companyNameArray[row]
    }
}
