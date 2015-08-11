//
//  main.m
//  ArrayFunctions
//
//  Created by Jian Su on 8/10/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        /**
         Immutable arrays can be defined as literals using the @[] syntax. This was added relatively late in the evolution
         of the language (Xcode 4.4), so you’re likely to encounter the more verbose arrayWithObjects: factory method at
         some point in your Objective-C career. Both options are included below.
         **/
        NSArray *germanMakes = @[@"Mercedes-Benz", @"BMW", @"Porsche",
                             @"Opel", @"Volkswagen", @"Audi"];
        
        NSArray *ukMakes = [NSArray arrayWithObjects:@"Aston Martin",
                           @"Lotus", @"Jaguar", @"Bentley", nil];
        
        NSLog(@"First german make: %@", germanMakes[0]);
        NSLog(@"First U.K. make: %@", [ukMakes objectAtIndex:0]);
        
        /**
         As you can see, individual items can be accessed through the square-bracket subscripting syntax (germanMakes[0])
         or the objectAtIndex: method. Prior to Xcode 4.4, objectAtIndex: was the standard way to access array elements.
         **/
        
        /** 
         Fast-enumeration is the most efficient way to iterate over an NSArray, and its contents are guaranteed to appear
         in the correct order. It’s also possible to use the count method with a traditional for-loop to step through each
         element in the array:
         **/
        
        // With fast-enumeration
        for (NSString *item in germanMakes) {
            NSLog(@"%@", item);
        }
        
        // With a traditional for loop
        for (int i=0; i<[germanMakes count]; i++) {
            NSLog(@"%d: %@", i, germanMakes[i]);
        }
        
        /**
         If you’re fond of blocks, you can use the enumerateObjectsUsingBlock: method. It works the same as NSSet’s
         version, except the index of each item is also passed to the block, so its signature looks like ^(id obj,
         NSUInteger idx, BOOL *stop). And of course, the objects are passed to the block in the same order as they appear
         in the array.
         **/
        [germanMakes enumerateObjectsUsingBlock:^(id obj,
                                                  NSUInteger idx,
                                                  BOOL *stop) {
            NSLog(@"%ld: %@", idx, obj);
        }];
        
        

    }
    return 0;
}
