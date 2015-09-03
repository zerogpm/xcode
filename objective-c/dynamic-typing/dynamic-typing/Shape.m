//
//  Shape.m
//  dynamic-typing
//
//  Created by Jian Su on 9/2/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import "Shape.h"

@implementation Shape

-(float)area {
    return 0.322;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"I am %@. My parent is %@. Area %f",[self class],[self superclass], [self area]];
}

@end
