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
        
        /** 
         Arrays can be compared for equality with the aptly named isEqualToArray: method, which returns YES when both
         arrays have the same number of elements and every pair pass an isEqual: comparison. NSArray does not offer the
         same subset and intersection comparisons as NSSet.
         **/
        NSArray *sameGermanMakes = [NSArray arrayWithObjects:@"Mercedes-Benz",
                                    @"BMW", @"Porsche", @"Opel",
                                    @"Volkswagen", @"Audi", nil];

        if ([germanMakes isEqualToArray:sameGermanMakes]) {
            NSLog(@"Oh good, literal arrays are the same as NSArrays");
        } else {
            NSLog(@"Oh no, they are not the same");
        }
        
        /** 
         NSArray provides similar membership checking utilities to NSSet. The containsObject: method works the exact same (it returns YES if the
         object is in the array, NO otherwise), but instead of member:, NSArray uses indexOfObject:. This either returns the index of the first
         occurrence of the requested object or NSNotFound if it’s not in the array.Since arrays can contain more than one reference to the same
         object, it’s possible that the first occurrence isn’t the only one. To find other occurrences, you can use the related
         indexOfObject:inRange: method.Remember that sets are more efficient for membership checking, so if you’re querying against a large
         collection of objects, you should probably be using a set instead of an array.
         **/
        
        //Bool Check
        if([germanMakes containsObject:@"BMW"]){
            NSLog(@"Found it, BMW is german Car");
        } else {
            NSLog(@"Nope Cannot Find it");
        }
        
        NSUInteger index = [germanMakes indexOfObject:@"BMW"];
        if (index == NSNotFound) {
            NSLog(@"I cannot find anything");
        } else {
            NSLog(@"BMW is at index %ld", index);
        }
        

    }
    return 0;
}
