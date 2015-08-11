//
//  main.m
//  LoopingthroughanNSMutableArray
//
//  Created by Jian Su on 8/10/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSMutableArray * myArray = [[NSMutableArray alloc]init];
        
        for (int i= 0; i <= 20; i++) {
            [myArray addObject:@(i)];
        }
        
        long int length = [myArray count];
        
        for (int k = 0; k<length; k++) {
            NSLog(@"The value is %@", myArray[k]);
        }
        
        
    }
    return 0;
}
