//
//  MainListVC.swift
//  FreshSlicePizza
//
//  Created by Chris Su on 2016-01-08.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit

class MainListVC: UIViewController {

    @IBOutlet weak var mainLists: UITableView!
    
    var mainListArray = ["Opening Closing List" , "Cleaning List", "Daily Sheet"]
    var openingData = OpeningData(description: "name", completed: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLists.dataSource = self
        mainLists.delegate = self
        
        openingData.downloadOpeningDetail({ () -> () in
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
}

extension MainListVC : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("mainListCell") as? mainListsCell {
            cell.configureCell(mainListArray[indexPath.row])
            return cell
        } else {
            return mainListsCell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainListArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 135.0
    }
}
