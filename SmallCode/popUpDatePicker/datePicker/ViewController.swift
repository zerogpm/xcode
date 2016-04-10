//
//  ViewController.swift
//  datePicker
//
//  Created by Jian Su on 2016-04-09.
//  Copyright © 2016 ZeroTech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var label: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  @IBAction func selectDate(sender: UIBarButtonItem) {
    DatePickerDialog().show("DatePickerDialog", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .Date) {
      (date) -> Void in
      self.label.text = "\(date)"
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

