//
//  main.m
//  Pointer
//
//  Created by Jian Su on 9/2/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>

void increamt(int *x);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int i = 100;
        printf("Value of i = %d\n", i);
        printf("Memory address of i = %p\n", &i);
        
        increamt(&i);
        
        printf("Value of incremented i = %d\n", i);
    }
    return 0;
}

void increamt(int *x) {
    printf("Memory address of x = %p\n", x);
    *x = *x + 1;
}