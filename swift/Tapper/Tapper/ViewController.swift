//
//  ViewController.swift
//  Tapper
//
//  Created by Jian Su on 2015-09-28.
//  Copyright © 2015 Jian Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //variables
    var maxTap:Int = 0
    var currentTap:Int = 0
    
    //outlet
    @IBOutlet weak var TapperLogo: UIImageView!
    @IBOutlet weak var tapTextField: UITextField!
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var tapsTxt: UILabel!
    @IBOutlet weak var coinBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func playBtnPress(sender: UIButton) {
        
        if tapTextField.text != nil && tapTextField.text != "" {
            TapperLogo.hidden = true
            tapTextField.hidden = true
            playBtn.hidden = true
            
            coinBtn.hidden = false
            tapsTxt.hidden = false
            
            maxTap = Int(tapTextField.text!)!
            currentTap = 0
            updateTaps()
        }
    }
    
    @IBAction func onCoinPress(sender: UIButton!) {
        if isGameOver() {
            currentTap++
            updateTaps()
        } else {
            reStartGame()
        }
    }
    
    func updateTaps() {
        tapsTxt.text = "\(currentTap)"
    }
    
    func isGameOver()->Bool {
        if currentTap >= maxTap {
            return false
        } else {
            return true
        }
    }
    
    func reStartGame() {
        maxTap = 0
        currentTap = 0
        tapTextField.text = ""
        TapperLogo.hidden = false
        tapTextField.hidden = false
        playBtn.hidden = false
        
        coinBtn.hidden = true
        tapsTxt.hidden = true
        
    }

}

