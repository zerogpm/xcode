//
//  ViewController.swift
//  Retro-Calculator
//
//  Created by Jian Su on 2015-10-09.
//  Copyright © 2015 Jian Su. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var currentOpeation: Operation = Operation.Empty
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay() //no need to wait when user press it
        }catch let err as NSError {
            print(err.debugDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func numberPress(btn: UIButton) {
        playSound()
        
        runningNumber += "\(btn.tag)"
        
        if Int(runningNumber) == 0{
            runningNumber = ""
            return
        }
        print(btn.titleLabel?.text)
        
        outputLbl.text = runningNumber
    }

    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }
    
    @IBAction func onSubractPressed(sender: AnyObject) {
        processOperation(Operation.Subtract)
    }
    
    @IBAction func onAddPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOpeation)
    }
    
    func processOperation(op: Operation) {
        playSound()
        
        if runningNumber.isEmpty {
            return
        }
        
        if currentOpeation != Operation.Empty {
            //Run some Math
            
            //A user selected an operator, but then selected another without
            //first entering a number
            if runningNumber != "" {
                rightValStr = runningNumber
                runningNumber = ""
                
                if currentOpeation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOpeation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOpeation == Operation.Subtract {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOpeation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                } else if currentOpeation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOpeation = op
            
        } else {
            //This is the first time an opeator has been pressed
            leftValStr = runningNumber
            runningNumber = ""
            currentOpeation = op
        }
    }
    
    func playSound() {
        
        //if the music is playing, stop it before play another sounds
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
}

