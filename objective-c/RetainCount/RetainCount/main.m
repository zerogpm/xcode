//
//  main.m
//  RetainCount
//
//  Created by Jian Su on 2015-09-03.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Book.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Book *book1 = [[Book alloc]init];
        //Book *book2 = book1;
        
        //This is how you can access the Retain count
        NSLog(@"Retain count is %ld", CFGetRetainCount((__bridge CFTypeRef)book1));
        
    }
    return 0;
}
