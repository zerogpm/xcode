//
//  main.m
//  dynamic-typing
//
//  Created by Jian Su on 9/2/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shape.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        Shape *shape = [[Shape alloc]init];
        NSArray *mixed = @[@23, @"tango", shape];
        
        //id meaning some kind of object, unspecified.
        for (id thing in mixed) {
            NSLog(@"%@", [thing description]);
        }
    }
    return 0;
}
