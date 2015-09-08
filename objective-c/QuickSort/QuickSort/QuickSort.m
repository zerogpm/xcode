//
//  QuickSort.m
//  QuickSort
//
//  Created by Jian Su on 2015-09-07.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import "QuickSort.h"

@implementation QuickSort

-(NSArray *)QuickSort:(NSMutableArray *)unSortedArray {
    NSMutableArray* lessArray = [[NSMutableArray alloc]init];
    NSMutableArray* greaterArray = [[NSMutableArray alloc]init];
    
    if ([unSortedArray count] < 1) {
        return nil;
    }
    
    int randomPivotPoint = arc4random() % [unSortedArray count];
    NSNumber * PivotValue = [unSortedArray objectAtIndex:randomPivotPoint];
    [unSortedArray removeObjectAtIndex:randomPivotPoint];
    
    for (NSNumber* num in unSortedArray) {
        if (num > PivotValue) {
            [lessArray addObject:num];
        } else {
            [greaterArray addObject:num];
        }
    }
    
    NSMutableArray* sortedArray = [[NSMutableArray alloc]init];
    [sortedArray addObjectsFromArray:[self QuickSort:lessArray]];
    [sortedArray addObject:PivotValue];
    [sortedArray addObjectsFromArray:[self QuickSort:greaterArray]];
    return sortedArray;
}

@end
