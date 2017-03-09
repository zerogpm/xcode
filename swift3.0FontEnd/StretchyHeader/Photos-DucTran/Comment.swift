//
//  Comment.swift
//  Photos-DucTran
//
//  Created by Duc Tran on 3/2/17.
//  Copyright © 2017 Developers Academy. All rights reserved.
//

import UIKit

struct Comment
{
    static func allComments() -> [Comment]
    {
        let comments = [
            Comment(user: .emily, text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat."),
            Comment(user: .brendon, text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat."),
            Comment(user: .chalene, text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat."),
            Comment(user: .tony, text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat."),
            Comment(user: .steve, text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat."),
            Comment(user: .mark, text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat.")
        ]
        
        return comments
    }
    
    enum User {
        case emily
        case brendon
        case chalene
        case tony
        case steve
        case mark
        
        func toString() -> String {
            switch self {
            case .emily:
                return "Emily"
            case .brendon:
                return "Brendon Burchard"
            case .chalene:
                return "Chalene Johnson"
            case .tony:
                return "Tony Robbins"
            case .steve:
                return "Steve Jobs"
            case .mark:
                return "Mark Zuckerberg"
            }
        }
        
        func toColor() -> UIColor {
            switch self {
            case .emily:
                return UIColor(red: 0.106, green: 0.686, blue: 0.125, alpha: 1)
            case .brendon:
                return UIColor(red: 0.114, green: 0.639, blue: 0.984, alpha: 1)
            case .chalene:
                return UIColor(red: 0.322, green: 0.459, blue: 0.984, alpha: 1)
            case .tony:
                return UIColor(red: 0.502, green: 0.290, blue: 0.984, alpha: 1)
            case .steve:
                return UIColor(red: 0.988, green: 0.271, blue: 0.282, alpha: 1)
            case .mark:
                return UIColor(red: 0.620, green: 0.776, blue: 0.153, alpha: 1)
            }
        }
    }
    
    let user: User
    let text: String
}
