//
//  NSString+Formatting.m
//  CategoryDemo
//
//  Created by Jian Su on 7/23/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import "NSString+Formatting.h"

@implementation NSString (Formatting)

-(NSString *)convertWithWhiteSpace {
    NSString *newString = [self stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    return newString;
}

-(NSString *)getRidOfWhiteSpace {
    NSString *newString = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    return newString;
}

@end
