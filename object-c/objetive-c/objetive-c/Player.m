//
//  Player.m
//  objetive-c
//
//  Created by Jian Su on 3/7/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import "Player.h"

@implementation Player

- (instancetype)init
{
    self = [super init];
    if (self) {
        _employeeID = 5000;
        _employeeName = @"Chris Su";
    }
    return self;
}

- (instancetype)initWithID:(int)employeeID initWithName:(NSString *)employeeName
{
    self = [super init];
    if (self) {
        _employeeID = employeeID;
        _employeeName = employeeName;
    }
    return self;
}

@end
