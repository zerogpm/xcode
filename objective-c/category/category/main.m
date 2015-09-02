//
//  main.m
//  category
//
//  Created by Jian Su on 9/2/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSArray+Mahem.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *letters = @[@"hello", @"there", @"chris"];
        NSLog(@"letters %@",letters);
        NSLog(@"cap %@", [letters capitalizeStrings]);
    }
    return 0;
}
