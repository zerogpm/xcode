//
//  employee.m
//  saveObject
//
//  Created by Jian Su on 7/21/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import "employee.h"

@implementation employee

-(NSString *) description {
    NSString *desc = [NSString stringWithFormat:@"\t Employee: %i \n \t Name: %@ %@ \n \t was hired on %@ \n --------", [self employeeID], [self firstname],[self lastname], [self hireDate]];
    return desc;
}

@end
