//
//  Task.h
//  controlproject
//
//  Created by Mario Velázquez Muñoz on 08/08/11.
//  Copyright (c) 2011 Casa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Task : NSManagedObject {
@private
    NSArray *sortedChanges;
}
@property (nonatomic, retain) NSNumber * cert;
@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSNumber * dev;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * reles;
@property (nonatomic, retain) NSNumber * state;
@property (nonatomic, retain) NSNumber * svn;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * closeDt;
@property (nonatomic, retain) NSDate * openDt;
@property (nonatomic, retain) NSSet *changes;
@property (nonatomic, retain) NSManagedObject *project;

@property (assign) NSArray *sortedChanges;
@end

@interface Task (CoreDataGeneratedAccessors)

- (void)addChangesObject:(NSManagedObject *)value;
- (void)removeChangesObject:(NSManagedObject *)value;
- (void)addChanges:(NSSet *)values;
- (void)removeChanges:(NSSet *)values;

- (void)orderChanges;

@end
