//
//  shiftSwapCell.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-03-24.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit

class shiftSwapCell: UITableViewCell {
    
    
    @IBOutlet weak var initial: UILabel!
    
    @IBOutlet weak var swapInitial: UILabel!
    
    @IBOutlet weak var yourDate: UILabel!
    @IBOutlet weak var yourTimeRange: UILabel!
    @IBOutlet weak var otherPersonFullName: UILabel!
    @IBOutlet weak var otherPersonDate: UILabel!
    @IBOutlet weak var otherPersonTimeRange: UILabel!
    
    @IBOutlet weak var myPosition: UILabel!
    
    @IBOutlet weak var swapPersonPosition: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(shiftSwapData: shiftSwap) {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if let userF = defaults.stringForKey(userFirstName), let userL = defaults.stringForKey(userLastName) {
            
            let firstInitial = String(userF[userF.startIndex])
            let secondInitial = String(userL[userL.startIndex])
            initial.text = "\(firstInitial.uppercaseString)\(secondInitial.uppercaseString)"
        }
        
        let swapFirstInitial = String(shiftSwapData.swapPersonFullName[shiftSwapData.swapPersonFullName.startIndex])
        
        let swapFirstInitialString = swapFirstInitial.uppercaseString
        
        if let rangOfEmptySpace = shiftSwapData.swapPersonFullName.rangeOfString(" ", options: NSStringCompareOptions.BackwardsSearch) {
            let suffix = String(shiftSwapData.swapPersonFullName.characters.suffixFrom(rangOfEmptySpace.endIndex))
            
            let swapSecondInitial = String(suffix[suffix.startIndex])
            let swapSecondInitialString = swapSecondInitial.uppercaseString
            swapInitial.text = "\(swapFirstInitialString)\(swapSecondInitialString)"
        }
        
        self.yourDate.text = shiftSwapData.myScheduledStart
        self.yourTimeRange.text = shiftSwapData.myTimeRange
        self.otherPersonFullName.text = shiftSwapData.swapPersonFullName
        self.otherPersonDate.text = shiftSwapData.swapPerosnScheduledStart
        self.otherPersonTimeRange.text = shiftSwapData.swapPersonTimeRange
        self.myPosition.text = shiftSwapData.myPosition
        self.swapPersonPosition.text = shiftSwapData.swapPersonPosition
    }
    
}
