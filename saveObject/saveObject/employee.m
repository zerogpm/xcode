//
//  employee.m
//  saveObject
//
//  Created by Jian Su on 7/21/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

#import "employee.h"

@implementation employee

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.firstname forKey:@"fname"];
    [aCoder encodeObject:self.lastname forKey:@"lname"];
    [aCoder encodeObject:self.hireDate forKey:@"hdate"];
    [aCoder encodeInt:self.employeeID forKey:@"ID"];
    
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if(self) {
        _firstname = [aDecoder decodeObjectForKey:@"fname"];
        _lastname = [aDecoder decodeObjectForKey:@"lname"];
        _hireDate = [aDecoder decodeObjectForKey:@"hdate"];
        _employeeID = [aDecoder decodeIntForKey:@"ID"];
    }
    return self;
}

-(NSString *) description {
    NSString *desc = [NSString stringWithFormat:@"\t Employee: %i \n \t Name: %@ %@ \n \t was hired on %@ \n --------", [self employeeID], [self firstname],[self lastname], [self hireDate]];
    return desc;
}

@end
