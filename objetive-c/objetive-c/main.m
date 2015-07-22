//
//  main.m
//  objetive-c
//
//  Created by Jian Su on 3/1/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Math.h"
#import "Player.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSFileManager *Desktop = [NSFileManager defaultManager];
        NSURL * desktopPath = [Desktop URLForDirectory:NSDesktopDirectory
                                              inDomain:NSUserDomainMask
                                     appropriateForURL:nil
                                                create:NO
                                                 error:nil];
        
        NSURL *fullpath = [desktopPath URLByAppendingPathComponent:@"photo/linux.txt"];
        NSMutableString *content = [[NSMutableString alloc]initWithContentsOfURL:fullpath encoding:NSUTF8StringEncoding error:nil];
        [content appendString:@"Changed!Change!"];
        
        NSURL *saveLocation = [desktopPath URLByAppendingPathComponent:@"photo/saved.txt"];
        [content writeToURL:saveLocation atomically:YES encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"url is %@", saveLocation);
        
//        NSFileManager * myFileManger = [NSFileManager defaultManager];
//        NSString *homeDirectory = NSHomeDirectory();
//        NSString *somePath = [homeDirectory stringByAppendingPathComponent:@"photo"];
//        NSLog(@"Home directory is %@", somePath);
//        
//        NSString * path = @"/Users/jiansu/Desktop/photo";
//        NSURL * newPath = [myFileManger URLForDirectory:NSDesktopDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
//        NSArray * imageFiles = [myFileManger subpathsAtPath:path];
//        
//        NSLog(@"The file manager method retrun %@", newPath);
    
        
        /**if ([myFileManger fileExistsAtPath:path]) {
            NSLog(@"Yes");
            NSDictionary * FileAttribute = [myFileManger attributesOfItemAtPath:path error:nil];
            for (NSString * key in FileAttribute) {
                NSLog(@"This is key %@ : %@ ", key, FileAttribute[key]);
            }
        } else {
            NSLog(@"the files does not exist");
            return 1;
        }**/
        
        
        
//        NSMutableDictionary *mycity = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"Canada", @"CA", @"USA", @"US", nil];
//        [mycity setObject:@"shenzhen" forKey:@"china"];
//        
//        for (NSString *city in mycity) {
//            NSLog(@"The key is %@ and the country is %@", city, [mycity objectForKey:city]);
//        }
    }
    return 0;
}
