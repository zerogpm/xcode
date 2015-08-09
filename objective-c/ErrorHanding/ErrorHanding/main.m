//
//  main.m
//  ErrorHanding
//
//  Created by Jian Su on 7/28/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        @try {
            id today = [[NSDate alloc]init];
            [today uppercaseString];
        }
        @catch (NSException *exception) {
            NSLog(@"there error is %@", exception);
        }
        @finally {
            NSLog(@"Error is here");
        }
    }
    return 0;
}
