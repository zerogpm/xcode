//
//  main.m
//  NSString
//
//  Created by Jian Su on 9/2/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString * mystring = @"hello ";
        NSString * mysecondString = @"there ";
        NSLog(@"%@", mystring);
        
        //concat two string
        NSString *concat = [[mystring stringByAppendingString:mysecondString] stringByAppendingString:@"Chris"];
        NSLog(@"%@", concat);
        
        //convert lower case to upper case
        NSString * upperCase = [concat uppercaseString];
        NSLog(@"%@", upperCase);
    }
    return 0;
}
