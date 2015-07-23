//
//  employee.h
//  saveObject
//
//  Created by Jian Su on 7/21/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface employee : NSObject <NSCoding>

@property NSString *firstname;
@property NSString *lastname;
@property NSDate *hireDate;
@property int employeeID;

@end
