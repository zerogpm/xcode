//
//  NewsItemCell.swift
//  StretchyHeaders
//
//  Created by Duc Tran on 5/28/15.
//  Copyright (c) 2015 Duc Tran. All rights reserved.
//

import UIKit

class NewsItemCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    var newsItem: NewsItem? {
        didSet {
            if let item = newsItem {
                categoryLabel.text = item.category.toString()
                categoryLabel.textColor = item.category.toColor()
                summaryLabel.text = item.summary
            } else {
                categoryLabel.text = nil
                summaryLabel.text = nil
            }
        }
    }
    
}
