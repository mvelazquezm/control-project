//
//  Project.m
//  controlproject
//
//  Created by Mario Velázquez Muñoz on 08/08/11.
//  Copyright (c) 2011 Casa. All rights reserved.
//

#import "Project.h"
#import "Task.h"


@implementation Project
@dynamic id;
@dynamic name;
@dynamic tasks;

@synthesize sortedTasks;

- (void)orderTasks {
    //NSArray *tasksArray = [[self tasks] allObjects];
    
    //NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"openDt" ascending:YES]];
    //[tasksArray sortedArrayUsingDescriptors:sortDescriptors];
    
    NSLog(@"Probamos con orderedTasks");
    
    [sortedTasks release];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"openDt" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];  
    NSArray *sortedArray = [[self tasks] sortedArrayUsingDescriptors:sortDescriptors];
    
    sortedTasks = [[NSArray alloc] initWithArray:sortedArray];

}



@end
