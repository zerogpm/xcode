//
//  numberOfDayPickerVC.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-06-23.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit

protocol numberOfDayPickerDelegate {
    func pickDay(Days:String)
}

class numberOfDayPickerVC: UIViewController {

    @IBOutlet weak var picker: UIPickerView!
    var delegate:numberOfDayPickerDelegate?
    
    var numberOfWeeks = ["0" , "1" , "2" , "3" , "4" , "5", "6", "7"]
    var pickedDay = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.dataSource = self
        picker.delegate = self
    }
    
    @IBAction func pickNumberOfDayPressed(sender: UIButton) {
        if delegate != nil {
            delegate?.pickDay(pickedDay)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }

}

extension numberOfDayPickerVC:UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberOfWeeks.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.pickedDay = numberOfWeeks[row]
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return numberOfWeeks[row]
    }
    
}
