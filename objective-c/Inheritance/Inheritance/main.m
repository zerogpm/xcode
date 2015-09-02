//
//  main.m
//  Inheritance
//
//  Created by Jian Su on 9/1/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shape.h"
#import "Circle.h"
#import "Button.h"
#import "Rectangle.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Shape * shape = [[Shape alloc]init];
        NSLog(@"shape area %f", [shape area]);
        
        Circle * round = [[Circle alloc]init];
        round.radius = 1.2;
        NSLog(@"Circle area %f", [round area]);
        
        Button * roundButton = [[Button alloc]init];
        roundButton.shape = round;
        
        Rectangle * retangle = [[Rectangle alloc]init];
        Button * squareButton = [[Button alloc]init];
        squareButton.shape = retangle;
    }
    return 0;
}
