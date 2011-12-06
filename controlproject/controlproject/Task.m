//
//  Task.m
//  controlproject
//
//  Created by Mario Velázquez Muñoz on 08/08/11.
//  Copyright (c) 2011 Casa. All rights reserved.
//

#import "Task.h"


@implementation Task
@dynamic cert;
@dynamic comment;
@dynamic dev;
@dynamic id;
@dynamic reles;
@dynamic state;
@dynamic svn;
@dynamic title;
@dynamic closeDt;
@dynamic openDt;
@dynamic changes;
@dynamic project;

@synthesize sortedChanges;

- (void)orderChanges {
    //NSArray *tasksArray = [[self tasks] allObjects];
    
    //NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"openDt" ascending:YES]];
    //[tasksArray sortedArrayUsingDescriptors:sortDescriptors];
    
    NSLog(@"Probamos con orderedChanges");
    
    [sortedChanges release];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"didit" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];  
    NSArray *sortedArray = [[self changes] sortedArrayUsingDescriptors:sortDescriptors];
    
    sortedChanges = [[NSArray alloc] initWithArray:sortedArray];
    
}

@end
