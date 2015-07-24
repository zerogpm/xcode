//
//  main.m
//  inheritanceAndOverring
//
//  Created by Jian Su on 7/23/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Article.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        Article *a = [[Article alloc]init];
        Article *b = [[Article alloc]init];
        Article *c = [[Article alloc]init];
        
        
        NSLog(@"Hello, World date is %@ \n %@ \n %@", a,b,c);
    }
    return 0;
}
