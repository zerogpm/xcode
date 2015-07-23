//
//  main.m
//  FindLocalTime
//
//  Created by Jian Su on 7/22/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //create date object
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
    }
    return 0;
}
