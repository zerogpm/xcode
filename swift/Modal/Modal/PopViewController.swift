//
//  PopViewController.swift
//  Modal
//
//  Created by Jian Su on 3/4/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

import UIKit

class PopViewController: UIViewController {

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var waringLabel: UILabel!
    
    @IBAction func dismiss(sender: AnyObject) {
        
        if userName.text == "chris" && password.text == "12345" {
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            waringLabel.text = "username and password is not right"
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
