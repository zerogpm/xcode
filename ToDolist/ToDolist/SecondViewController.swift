//
//  SecondViewController.swift
//  ToDolist
//
//  Created by Jian Su on 4/4/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var item: UITextField!
    
    @IBAction func AddItem(sender: AnyObject) {
        toDoList.append(item.text)
        
        item.text = ""
        
        NSUserDefaults.standardUserDefaults().setObject(toDoList, forKey: "ToDoList")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(TextField: UITextField!) -> Bool {
        
        item.resignFirstResponder()
        return true
    }

}

