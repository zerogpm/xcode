//
//  ResponseJSONObjectSerializable.swift
//  RestApiToTableView
//
//  Created by Jian Su on 1/17/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol ResponseJSONObjectSerializable {
    init?(json: SwiftyJSON.JSON)
}