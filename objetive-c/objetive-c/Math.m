//
//  Math.m
//  objetive-c
//
//  Created by Jian Su on 3/7/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import "Math.h"

@implementation Math

- (instancetype)init
{
    self = [super init];
    if (self) {
        _number1 = 5;
        _number2 = 6;
    }
    return self;
}

-(int)returnInit {
    int value;
    value = _number2 * _number1;
    return value;
}

- (instancetype)initWithLowScore
{
    self = [super init];
    if (self) {
        _lowestScore = 10;
    }
    return self;
}

-(int) addTwoNumber:(int)firstNum addSecondNum:(int)secondNum{
    int result = firstNum + secondNum;
    return result;
}

-(void)mutipleOneNumber:(int)firstNum mutipleSecond:(int)secondNumOne{
    int result = firstNum * secondNumOne;
    NSLog(@"The final result is %i", result);
}

@end
