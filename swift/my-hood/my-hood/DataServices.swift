//
//  DataServices.swift
//  my-hood
//
//  Created by Jian Su on 12/26/15.
//  Copyright © 2015 Jian Su. All rights reserved.
//

import Foundation
import UIKit

class DataService {
    static let instance = DataService()
    let KEY_POSTS = "posts"
    private var _loadedPost = [Post]()
    
    var loadedPost:[Post] {
        return _loadedPost
    }
    
    func savePosts() {
        let postsData = NSKeyedArchiver.archivedDataWithRootObject(_loadedPost)
        NSUserDefaults.standardUserDefaults().setObject(postsData, forKey: KEY_POSTS)
    }
    
    func loadPosts() {
        if let postsData = NSUserDefaults.standardUserDefaults().objectForKey(KEY_POSTS) as? NSData {
            if let postArray = NSKeyedUnarchiver.unarchiveObjectWithData(postsData) as? [Post] {
                _loadedPost = postArray
            }
        }
        
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "postsLoaded", object: nil))
    }
    
    func saveImageAndCreatePath(image: UIImage) {
        
    }
    
    func imageForPath(path: String) {
        
    }
    
    func addPost(post:Post) {
        _loadedPost.append(post)
        savePosts()
        loadPosts()
    }
}