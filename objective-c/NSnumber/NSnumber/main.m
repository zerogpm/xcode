//
//  main.m
//  NSnumber
//
//  Created by Jian Su on 9/1/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSNumber * mike;
        mike = [[NSNumber alloc]initWithInt:23];
        NSLog(@"mike is %@", mike);
        
        mike = @32;
        NSLog(@"mike is %@", mike);
        
        NSNumber *pi = @3.33;
        NSLog(@"mike is %@", pi);
        
    }
    return 0;
}
