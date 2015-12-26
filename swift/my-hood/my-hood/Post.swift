//
//  Post.swift
//  my-hood
//
//  Created by Jian Su on 12/25/15.
//  Copyright © 2015 Jian Su. All rights reserved.
//

import Foundation

class Post {
    
    private var _imagePath: String
    private var _title: String
    private var _postDesc: String
    
    var imagePath:String {
        return _imagePath
    }
    
    var title:String {
        return _title
    }
    
    var postDesc:String {
        return _postDesc
    }
    
    init(imagePath:String,title:String,postDesc:String){
        self._imagePath = imagePath
        self._title = title
        self._postDesc = postDesc
    }
    
}