//
//  main.m
//  CategoryDemo
//
//  Created by Jian Su on 7/23/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+Formatting.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSString * message = @"This is some string man";
        NSString * newString = [message convertWithWhiteSpace];
        NSLog(@"%@", newString);
        
        NSString * whiteSpace = [message getRidOfWhiteSpace];
        NSLog(@"%@", whiteSpace);
    }
    return 0;
}
