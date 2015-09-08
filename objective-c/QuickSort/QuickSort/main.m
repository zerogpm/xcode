//
//  main.m
//  QuickSort
//
//  Created by Jian Su on 2015-09-07.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuickSort.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray* unsorted = [[NSMutableArray alloc]init];
        [unsorted addObject:@3];
        [unsorted addObject:@33];
        [unsorted addObject:@47];
        [unsorted addObject:@32];
        [unsorted addObject:@11];
        QuickSort* sort = [[QuickSort alloc]init];
        NSArray* sorted = [[NSArray alloc]init];
        sorted = [sort QuickSort:unsorted];
        NSLog(@"%@", sorted);
    }
    return 0;
}
