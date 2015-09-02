//
//  main.m
//  NSArray
//
//  Created by Jian Su on 9/2/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray * foo = [[NSArray alloc]initWithObjects:@"f", @"o" , @"o", nil];
        
        //Arrary literal
        NSArray * foo2 = @[@"Chris", @"Su"];
        NSLog(@"%@ %@", foo2[0], foo2[1]);
        
        NSLog(@"%@", foo);
        
        //loop the array
        for (NSString *string in foo) {
            NSLog(@"%@",string);
        }
        
        //access array manunally
        NSString *element = foo[2];
        NSLog(@"%@", element);
        
        //NSMutableArray
        NSMutableArray *lots = [[NSMutableArray alloc]init];
        lots[0] = @"yo";
        lots[1] = @"man";
        lots[2] = @"I am happy";
        NSLog(@"%@", lots);
        
        //remove element at index
        [lots removeObjectAtIndex:2];
        NSLog(@"%@", lots);
    }
    return 0;
}
