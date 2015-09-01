//
//  main.m
//  myFirstObjective
//
//  Created by Jian Su on 2015-09-01.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "shape.h"
#import "Circle.h"
#import "Button.h"
#import "Rectangle.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        shape *shapes = [[shape alloc]init];
        NSLog(@"shape area %f", [shapes area]);
        Circle * round = [[Circle alloc]init];
        round.radius = 1.2;
        NSLog(@"Circle area %f", [round area]);
        
        Rectangle * retangle = [[Rectangle alloc]init];
        
        Button * Squarebutton = [[Button alloc]init];
        Squarebutton.shapes = retangle;
        
        
    }
    return 0;
}
