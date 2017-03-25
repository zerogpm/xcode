//
//  QuestionBank.swift
//  Quotes
//
//  Created by Jian Su on 2017-03-15.
//  Copyright © 2017 ZeroTech. All rights reserved.
//

import Foundation

class QMeGame {
  
  var quesiton:[String] = [
    "what is your age",
    "what is your name",
    "what do you want to be",
    "how is your career path",
    "what do you do?",
    "Am I right?"
  ]
  
  var questionImageNames:[String] = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6"
  ]
  
  var currentQuestionIndex = 0
  
  var point = 0
  
  func getTheNextQuestion() -> String {
    
    if currentQuestionIndex == (quesiton.count - 1) {
      currentQuestionIndex = 0
    } else {
      currentQuestionIndex += 1
    }
    
    let nextQuestion = quesiton[currentQuestionIndex]
    return nextQuestion
  }
  
  func getQuestionImageName() -> String {
    return self.questionImageNames[currentQuestionIndex]
  }
  
}
