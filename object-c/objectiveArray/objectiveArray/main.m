//
//  main.m
//  objectiveArray
//
//  Created by Jian Su on 3/7/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        int mutipleValues[] = {100,10002,100022,121212,12222,2000};
        NSLog(@"The array 2 value is %i", mutipleValues[3]);
        
        NSDate *myDate = [[NSDate alloc]init];
        
        
        NSArray *ArrayString = [[NSArray alloc] initWithObjects:@"ok",@"man", myDate,nil];
        NSLog(@"ArrayString %@", ArrayString[2]);
        
        //short hand for non mutable NSArray
        NSArray *shortNSarray= @[@"first",@"second",myDate];
        NSLog(@"This is all the object %@ %@ %@", shortNSarray[0],shortNSarray[1],shortNSarray[2]);
        
        NSMutableArray * mutableArray = [[NSMutableArray alloc] initWithObjects:@"Something", nil];
        NSString * SomethingString = @"you man";
        
        //add remove element to mutable Array
        [mutableArray addObject:SomethingString];
        [mutableArray removeObjectAtIndex:0];
        NSLog(@"Mutable Array %@", [mutableArray objectAtIndex:0]);
        
        /*----------------------------------------------------------*/
        //Dictionary
        NSDictionary * states = [[NSDictionary alloc]
                               initWithObjectsAndKeys:@"Arizona",@"AZ",
                               @"California", @"CA",
                               @"Colorado", @"CO",
                               @"Hawaii", @"HI",
                               @"New Mexico",@"NM",nil];
        
        NSString * someState = @"HI";
        NSLog(@" %@ is for %@", someState, [states objectForKey:someState]);
        //short hand
        NSLog(@" %@ is for %@", someState, states[someState]);
        
        //MutableDictionary
        
        NSMutableDictionary * china = [[NSMutableDictionary alloc]
                                 initWithObjectsAndKeys:@"深圳",@"SZ",
                                 @"广州", @"GZ",
                                 @"大连", @"DL",
                                 @"北京", @"BJ",
                                 @"厦门",@"XM",nil];
        
        [china setObject:@"天津" forKey:@"TJ"];
        NSString *chinaCity = @"TJ";
        
        //short hand for non mutable dictionary
        NSDictionary * someCity = @{@"SH" : @"上海"};
        NSString * anotherCity = @"SH";
        NSLog(@"SH is short for %@", someCity[anotherCity]);
        
        NSLog(@" %@ is for %@", chinaCity, china[chinaCity]);
        
        //Fast Enumeration
        NSString *soundPath = @"/System/Library/Sounds";
        NSFileManager *fileManager = [[NSFileManager alloc]init];
        
        NSArray *soundFiles = [fileManager subpathsAtPath:soundPath];
        
        for (NSString  * files in soundFiles) {
            NSLog(@"The files Name is %@", files);
        }
    }
    return 0;
}
