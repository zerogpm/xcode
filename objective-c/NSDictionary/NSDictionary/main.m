//
//  main.m
//  NSDictionary
//
//  Created by Jian Su on 9/2/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSDictionary *book = [[NSDictionary alloc]initWithObjectsAndKeys:@"The cat in the Hat",@"title",@"Dr.Seuss",@"Author", nil];
        NSLog(@"%@", book);
        
        //something more readable
        NSDictionary *newBook = @{@"title":@"The dog in the Hat", @"author":@"Dr.zeuss"};
        
        //get the Dictionay value
        NSString *value = [newBook objectForKey:@"title"];
        NSLog(@"%@", value);
        
        //create a mutable array from a non-mutable array
        NSMutableDictionary *mutableBook = [NSMutableDictionary dictionaryWithDictionary:book];
        [mutableBook setObject:@"1956" forKey:@"year"];
        NSLog(@"%@", mutableBook);
        
        //loop through the dictionary for key only
        for (NSString* string in mutableBook) {
            NSLog(@"%@",string);
        }
        
        //loop through the dictionay with key and value
        for (NSString* string in [mutableBook allKeys]) {
            NSLog(@"key %@ value %@", string, [mutableBook objectForKey:string]);
        }
        
    }
    return 0;
}
