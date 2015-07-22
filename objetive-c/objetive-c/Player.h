//
//  Player.h
//  objetive-c
//
//  Created by Jian Su on 3/7/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Player : NSObject


@property int employeeID;
@property NSString * employeeName;
- (instancetype)initWithID:(int)employeeID initWithName:(NSString *)employeeName;

@end
