//
//  ViewController.swift
//  NSUserDefault
//
//  Created by Jian Su on 11/30/15.
//  Copyright © 2015 Jian Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var favLabel: UILabel!
    
    var people = [Person]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let color = NSUserDefaults.standardUserDefaults().valueForKey("color") as? String {
            favLabel.text = "Favorite color is \(color)"
        } else {
            favLabel.text = "Pick a color!"
        }
        
        let personA = Person(first: "Chris", last: "Su")
        let personB = Person(first: "Wing", last: "Chun")
        let personC = Person(first: "Lady", last: "Gaga")
        
        people.append(personA)
        people.append(personB)
        people.append(personC)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func purp(sender: AnyObject) {
        favLabel.text = "Favorite Color: Purp"
        NSUserDefaults.standardUserDefaults().setValue("Purp", forKey: "color")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    @IBAction func red(sender: AnyObject) {
        favLabel.text = "Favorite Color: Red"
        NSUserDefaults.standardUserDefaults().setValue("Red", forKey: "color")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
   
    @IBAction func orange(sender: AnyObject) {
        favLabel.text = "Favorite Color: orange"
        NSUserDefaults.standardUserDefaults().setValue("orange", forKey: "color")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    

}

