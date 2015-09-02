//
//  NSArray+Mahem.m
//  category
//
//  Created by Jian Su on 9/2/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import "NSArray+Mahem.h"

@implementation NSArray (Mahem)
-(NSArray *)capitalizeStrings {
    //Capitalized the first letter of the string
    NSMutableArray *cap = [NSMutableArray array];
    for (NSString* string in self) {
        [cap addObject:[string capitalizedString]];
    }
    
    return cap;
}
@end
