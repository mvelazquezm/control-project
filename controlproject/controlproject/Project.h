//
//  Project.h
//  controlproject
//
//  Created by Mario Velázquez Muñoz on 08/08/11.
//  Copyright (c) 2011 Casa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Task;

@interface Project : NSManagedObject {
@private
    NSArray *sortedTasks;
}
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *tasks;

@property (assign) NSArray *sortedTasks;

@end

@interface Project (CoreDataGeneratedAccessors)

- (void)addTasksObject:(Task *)value;
- (void)removeTasksObject:(Task *)value;
- (void)addTasks:(NSSet *)values;
- (void)removeTasks:(NSSet *)values;

- (void)orderTasks;

@end
