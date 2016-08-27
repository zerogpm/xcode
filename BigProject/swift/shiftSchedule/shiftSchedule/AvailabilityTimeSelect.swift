//
//  AvailabilityTimeSelect.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-06-22.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit

protocol EffectiveDateEnteredDelegate {
    func userPickedDateInfo(selectedDate:NSDate)
}

class AvailabilityTimeSelect: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var delegate:EffectiveDateEnteredDelegate?
    var selectedDate:NSDate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedDate = NSDate()
        datePicker.addTarget(self, action: #selector(AvailabilityTimeSelect.datePickerChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    func datePickerChanged(datePicker:UIDatePicker) {
        self.selectedDate = datePicker.date
    }
    
    @IBAction func selectedDateButtonPressed(sender: UIButton) {
        if delegate != nil {
            delegate?.userPickedDateInfo(selectedDate!)
            self.navigationController?.popViewControllerAnimated(true)
        }
    }

}
