//
//  OpeningClosingVC.swift
//  FreshSlicePizza
//
//  Created by Chris Su on 2016-01-11.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit

class OpeningClosingVC: UIViewController {

    @IBOutlet weak var openLists: UITableView!
        
    var openingObjects = [OpeningData]()

    override func viewDidLoad() {
        super.viewDidLoad()
        openLists.delegate = self
        openLists.dataSource = self
        
        let openingObject = OpeningData(description: "Coolers Temp (1 to 4 C) Freezer (-10 to -18 C)", completed: false)
        
        let openingObject2 = OpeningData(description: "Count Number Of Pizza Wasted & Dump Them", completed: false)
        
        let openingObject3 = OpeningData(description: "Fill Up The Cash Formr And Write The total Amount", completed: false)
        
        let openingObject4 = OpeningData(description: "Fill Up The Cash Formr And Write The total Amount", completed: false)
        
        let openingObject5 = OpeningData(description: "Fill Up The Cash Formr And Write The total Amount", completed: false)
        
        let openingObject6 = OpeningData(description: "Fill Up The Cash Formr And Write The total Amount", completed: false)
        
        let openingObject7 = OpeningData(description: "Fill Up The Cash Formr And Write The total Amount", completed: false)
        
        let openingObject8 = OpeningData(description: "Fill Up The Cash Formr And Write The total Amount", completed: false)
        
        let openingObject9 = OpeningData(description: "Fill Up The Cash Formr And Write The total Amount", completed: false)
        
        let openingObject10 = OpeningData(description: "Fill Up The Cash Formr And Write The total Amount", completed: false)
        
        let openingObject11 = OpeningData(description: "Fill Up The Cash Formr And Write The total Amount", completed: false)
        
        let openingObject12 = OpeningData(description: "Count Number Of Pizza Wasted & Dump Them", completed: false)
        
        let openingObject13 = OpeningData(description: "Count Number Of Pizza Wasted & Dump Them", completed: false)
        
        let openingObject14 = OpeningData(description: "Count Number Of Pizza Wasted & Dump Them", completed: false)
        
        openingObjects.append(openingObject)
        openingObjects.append(openingObject2)
        openingObjects.append(openingObject3)
        openingObjects.append(openingObject4)
        openingObjects.append(openingObject5)
        openingObjects.append(openingObject6)
        openingObjects.append(openingObject7)
        openingObjects.append(openingObject8)
        openingObjects.append(openingObject9)
        openingObjects.append(openingObject10)
        openingObjects.append(openingObject11)
        openingObjects.append(openingObject12)
        openingObjects.append(openingObject13)
        openingObjects.append(openingObject14)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
}

extension OpeningClosingVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let openingObject = openingObjects[indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("OpeingCell") as? OpeningCell {
            cell.configureCell(openingObject)
            return cell
        } else {
            return OpeningCell()
        }

        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return openingObjects.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 68.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let openingObject = openingObjects[indexPath.row]
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        openingObject.completed = !openingObject.completed
        
        if openingObject.completed {
            cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell?.accessoryType = UITableViewCellAccessoryType.None
        }
    }
    
}

