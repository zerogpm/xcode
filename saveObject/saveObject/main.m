//
//  main.m
//  saveObject
//
//  Created by Jian Su on 7/21/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "employee.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        //create date objec
        NSDate *TimeZone = [NSDate date];
        //find out destination and source time zone value
        NSTimeZone *sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"GMT"];
        NSTimeZone *destinationTimeZone = [NSTimeZone systemTimeZone];
        //find out destination and source offset value
        NSInteger sourceGMTOffSet = [sourceTimeZone secondsFromGMTForDate:TimeZone];
        NSInteger destinationOffSet = [destinationTimeZone secondsFromGMTForDate:TimeZone];
        
        //find the differences between destionation and source offset value
        NSTimeInterval interval = destinationOffSet - sourceGMTOffSet;
        NSDate *destinationDate = [[NSDate alloc]initWithTimeInterval:interval sinceDate:TimeZone];
        NSLog(@"local is %@", destinationDate);

        
        employee *bob = [[employee alloc]init];
        [bob setFirstname:@"bob"];
        [bob setLastname:@"cooler"];
        [bob setEmployeeID:1231];
        [bob setHireDate:[NSDate date]];
        
        employee *Alice = [[employee alloc]init];
        Alice.firstname = @"Alice";
        Alice.lastname = @"su";
        Alice.employeeID = 12334;
        Alice.hireDate = [NSDate dateWithTimeIntervalSinceNow:0];
        
        NSLog(@"First Employee: \n %@", [bob description]);
        NSLog(@"Second Employe: \n %@", Alice);
        
    }
    return 0;
}
