//
//  CancelShiftCell.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-04-19.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit

class CancelShiftCell: UITableViewCell {

    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var timeRange: UILabel!
    @IBOutlet weak var initial: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(employeeReleaseData: EmployeeReleaseRequest) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let userF = defaults.stringForKey(userFirstName), let userL = defaults.stringForKey(userLastName) {
            
            let firstInitial = String(userF[userF.startIndex])
            let secondInitial = String(userL[userL.startIndex])
            
            let firstInitialString = firstInitial.uppercaseString
            let secondInitialString = secondInitial.uppercaseString
            initial.text = "\(firstInitialString)\(secondInitialString)"
        }
        
        self.date.text = employeeReleaseData.scheduledStart
        self.timeRange.text = employeeReleaseData.timeRange
    }
    

}
