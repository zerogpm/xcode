//
//  Course.h
//  SaveDemoCoreData
//
//  Created by Jian Su on 2015-09-25.
//  Copyright © 2015 Jian Su. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Course : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

-(void) simpleMethod;

@end

NS_ASSUME_NONNULL_END

#import "Course+CoreDataProperties.h"
