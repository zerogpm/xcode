//
//  ViewController.swift
//  oldSchoolMath
//
//  Created by Jian Su on 2015-10-01.
//  Copyright © 2015 Jian Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLbl: UILabel!
    
    var phrases = ["Booting from floppy...\n", "Reading from disk...\n", "Updating Registry...\n","......\n","........................\n","Weclome Chris \n It is nice to see you again"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLbl.text = ""
//        for var i = 0; i < phrases.count; i++ {
//            var txt = mainLbl.text!
//            txt += phrases[i]
//            mainLbl.text = txt
//        }
    
        for phrase in phrases {
            var txt = mainLbl.text!
            txt += phrase
            mainLbl.text = txt
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

