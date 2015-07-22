//
//  ViewController.swift
//  TableControl
//
//  Created by Jian Su on 2/22/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    let devCoures = [
        ("IOS App Dev with Swift Essential" , "Simon Allardice"),
        ("IOS 8 SDK New Features", "Lee Brimelow"),
        ("Data Visualization with D3.js", "Ray Villalobs"),
        ("Swift Essential Training", "Simon Allardice"),
        ("up and Running with AngularJS", "Ray Villalbos"),
        ("Building Adaptive Android Apps with Fragments", "David Gassner")
    ]
    
    let webCourses = [
        ("HTML Essential Training", "James Williamson"),
        ("Building a Responsive Single-page", "Ray Villalobos")
    ]

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return devCoures.count
        } else {
            return webCourses.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        if indexPath.section == 0 {
            let (courseTitle, courseAuthor) = devCoures[indexPath.row]
            cell.textLabel?.text = courseTitle
            cell.detailTextLabel?.text = courseAuthor
        } else {
            let (courseTitle, courseAuthor) = webCourses[indexPath.row]
            cell.textLabel?.text = courseTitle
            cell.detailTextLabel?.text = courseAuthor
        }
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Developer course"
        } else {
            return "Web Developer Courses"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

