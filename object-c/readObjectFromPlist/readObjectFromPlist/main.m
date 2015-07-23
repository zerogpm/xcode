//
//  main.m
//  readObjectFromPlist
//
//  Created by Jian Su on 7/22/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "employee.h"

NSString* getPropertyListPath() {
    NSURL *employeePath = [[NSFileManager defaultManager]URLForDirectory:NSDesktopDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
    NSURL *plist = [employeePath URLByAppendingPathComponent:@"photo/employees.plist"];
    return plist.path;
}

void createAndArchiveObject(NSString *filePath) {
    
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
    
    
    employee *bob = [[employee alloc]init];
    [bob setFirstname:@"bob"];
    [bob setLastname:@"cooler"];
    [bob setEmployeeID:1231];
    [bob setHireDate:[NSDate date]];
    
    employee *Alice = [[employee alloc]init];
    Alice.firstname = @"Alice";
    Alice.lastname = @"su";
    Alice.employeeID = 12334;
    Alice.hireDate = destinationDate;
    
    //create mutable array to hold Alice and bob objects
    NSMutableArray *employees = [[NSMutableArray alloc]init];
    [employees addObject:bob];
    [employees addObject:Alice];
    
    [NSKeyedArchiver archiveRootObject:employees toFile:filePath];
    NSLog(@"Objects created!");
}

void readSaveObject(NSString* filePath) {
    NSMutableArray *employees = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    for (employee * e in employees) {
        NSLog(@"The objects are %@", e);
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSString *path = getPropertyListPath();

        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            //Yes, The file's there - load them in
            readSaveObject(path);
        } else {
            //No, the files is not there
            createAndArchiveObject(path);
        }
    }
    return 0;
}
