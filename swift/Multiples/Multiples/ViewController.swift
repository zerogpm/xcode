//
//  ViewController.swift
//  Multiples
//
//  Created by Jian Su on 2015-09-29.
//  Copyright © 2015 Jian Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mutipleTextField:UITextField!
    @IBOutlet weak var playBtn:UIButton!
    @IBOutlet weak var PressToAddLabel:UILabel!
    @IBOutlet weak var addBtn:UIButton!
    @IBOutlet weak var mutipleLogo:UIImageView!
    var currentMutipleNumber:Int = 0
    var currentNumber:Int = 0
    let maxNumber:Int = 100
    var finalResult:Int = 0
    
    @IBAction func PressToPlay(sender: UIButton) {
        if mutipleTextField.text != nil && mutipleTextField.text != "" {
            mutipleLogo.hidden = true
            mutipleTextField.hidden = true
            playBtn.hidden = true
            PressToAddLabel.hidden = false
            addBtn.hidden = false
            
            currentMutipleNumber = Int(mutipleTextField.text!)!
        }
    }
    
    @IBAction func AddToNumber(sender: UIButton) {
        if isTheGameOver() {
            restartTheGame()
        } else {
            updateLabel()
        }
    }
    
    func isTheGameOver() -> Bool {
        if currentNumber >= maxNumber {
            return true
        } else {
            return false
        }
    }
    
    func restartTheGame() {
        mutipleLogo.hidden = false
        mutipleTextField.hidden = false
        playBtn.hidden = false
        PressToAddLabel.hidden = true
        addBtn.hidden = true
        currentNumber = 0
        currentMutipleNumber = 0
        finalResult = 0
        mutipleTextField.text = ""
        PressToAddLabel.text = "Press To ADD!"
    }
    
    func updateLabel() {
        finalResult = currentNumber + currentMutipleNumber
        PressToAddLabel.text = "\(currentNumber) + \(currentMutipleNumber) = \(finalResult)"
        currentNumber += currentMutipleNumber
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

