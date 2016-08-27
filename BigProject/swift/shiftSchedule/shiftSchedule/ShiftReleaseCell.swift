//
//  ShiftReleaseCell.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-03-29.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit

class ShiftReleaseCell: UITableViewCell {
    
    @IBOutlet weak var pendingMessage: UILabel!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var timeRange: UILabel!
    
    @IBOutlet weak var position: UILabel!
    
    @IBOutlet weak var initial: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(OtherReleaseData: OtherReleaseRequest) {
        
        let firstInitial = String(OtherReleaseData.fullName[OtherReleaseData.fullName.startIndex])
        
        let firstInitialString = firstInitial.uppercaseString
        
        if let rangOfEmptySpace = OtherReleaseData.fullName.rangeOfString(" ", options: NSStringCompareOptions.BackwardsSearch) {
            let suffix = String(OtherReleaseData.fullName.characters.suffixFrom(rangOfEmptySpace.endIndex))
            
            let secondInitial = String(suffix[suffix.startIndex])
            
            let secondInitialString = secondInitial.uppercaseString
            
            initial.text = "\(firstInitialString)\(secondInitialString)"
        }
        
        self.userName.text = OtherReleaseData.fullName
        self.position.text = OtherReleaseData.position
        self.date.text = OtherReleaseData.scheduledStart
        self.timeRange.text = OtherReleaseData.timeRange
        if OtherReleaseData.userChangeApproved == "0" {
            self.pendingMessage.text = "Pending User Pickup"
        } else {
            self.pendingMessage.text = "Awaiting Manager Approval"
        }
    }
}
