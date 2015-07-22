//
//  Math.h
//  objetive-c
//
//  Created by Jian Su on 3/7/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Math : NSObject

@property int number1;
@property int number2;
@property int lowestScore;

-(int) addTwoNumber: (int) firstNum addSecondNum: (int) secondNum;

-(void) mutipleOneNumber: (int) firstNum
           mutipleSecond:(int) secondNumOne;

-(int) returnInit;

-(instancetype)initWithLowScore;

@end
