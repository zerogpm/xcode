//
//  OtherSwapCell.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-04-20.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit

class OtherSwapCell: UITableViewCell {
    

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var myScheduledStart: UILabel!
    
    @IBOutlet weak var initial: UILabel!
    
    @IBOutlet weak var swapPersonTimeRange: UILabel!
    @IBOutlet weak var swapPerosnScheduledStart: UILabel!
    @IBOutlet weak var swapPersonFullName: UILabel!
    @IBOutlet weak var myTimeRange: UILabel!
    
    @IBOutlet weak var swapInitial: UILabel!
    
    @IBOutlet weak var myPosition: UILabel!
    
    @IBOutlet weak var swapPersonPosition: UILabel!
    var swapPersonF = ""
    var swapPersonL = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(otherShiftSwapData: OtherShiftSwap) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let userF = defaults.stringForKey(userFirstName), let userL = defaults.stringForKey(userLastName) {
            let firstNameInitialString = String(userF[userF.startIndex])
            let lastNameInitialString = String(userL[userL.startIndex])
            initial.text = "\(firstNameInitialString)\(lastNameInitialString)"
        }
        
        self.swapPersonF = String(otherShiftSwapData.swapPersonFullName[otherShiftSwapData.swapPersonFullName.startIndex])
        
        if let rangOfEmptySpace = otherShiftSwapData.swapPersonFullName.rangeOfString(" ", options: NSStringCompareOptions.BackwardsSearch) {
            let suffix = String(otherShiftSwapData.swapPersonFullName.characters.suffixFrom(rangOfEmptySpace.endIndex))
            self.swapPersonL = String(suffix[suffix.startIndex])
        }
        
        if otherShiftSwapData.shiftStatus == "Awaiting Manager Approval." {
            self.status.textColor = UIColor(red: 245/255, green: 166/255, blue: 35/255, alpha: 1.0)
        } else {
            self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            self.status.textColor = UIColor(hue: 213/360, saturation: 84/100, brightness: 79/100, alpha: 1.0)
        }
        
        self.status.text = otherShiftSwapData.shiftStatus
        swapInitial.text = "\(swapPersonF)\(swapPersonL)"
        self.myScheduledStart.text = otherShiftSwapData.myScheduledStart
        self.myTimeRange.text = otherShiftSwapData.myTimeRange
        self.swapPersonFullName.text = otherShiftSwapData.swapPersonFullName
        self.swapPerosnScheduledStart.text = otherShiftSwapData.swapPerosnScheduledStart
        self.swapPersonTimeRange.text = otherShiftSwapData.swapPersonTimeRange
        self.swapPersonPosition.text = otherShiftSwapData.swapPersonPosition
        self.myPosition.text = otherShiftSwapData.myPosition
    }
}
