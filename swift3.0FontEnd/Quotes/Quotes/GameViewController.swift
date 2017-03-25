//
//  GameViewController.swift
//  Quotes
//
//  Created by Jian Su on 2017-03-15.
//  Copyright © 2017 ZeroTech. All rights reserved.
//

import UIKit

class GameViewController : UIViewController {
  
  @IBOutlet weak var pointLabel: UILabel!
  @IBOutlet weak var questionImageView: UIImageView!
  @IBOutlet weak var questionLable: UILabel!
  @IBOutlet weak var falseButton:UIButton!
  
  var game: QMeGame = QMeGame()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    pointLabel.text = "--"
    let starImage = UIImage(named: "2")
    questionImageView.image = starImage
    questionLable.text = "Tap the start button to start a new game"
    
    falseButton.isEnabled = false
  }
  
  @IBAction func trueButtonDidTap(_ sender: UIButton) {
    
    if pointLabel.text == "--" {
      game.point = 0
      falseButton.isEnabled = true
    } else {
      game.point += 1
    }

    updateGame()
  }
  
  @IBAction func falseButtonDidTap(_ sender: UIButton) {
    game.point -= 1
    updateGame()
  }
  
  func updateGame() {
    let nextQuestion = game.getTheNextQuestion()
    let questionImage = game.getQuestionImageName()
    let image = UIImage(named: questionImage)
    questionImageView.image = image
    questionLable.text = nextQuestion
    pointLabel.text = "\(game.point)"
  }
  
}
