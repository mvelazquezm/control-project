//
//  TableTaskDS.m
//  controlproject
//
//  Created by Mario Velázquez Muñoz on 17/08/11.
//  Copyright 2011 Casa. All rights reserved.
//

#import "TableTaskDS.h"

#import "Task.h"

@implementation TableTaskDS

@synthesize project;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        project = nil;
    }
    
    return self;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    if (project == nil)
        return 0;
    else
        return [[project tasks] count];
}


- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
    
    if (project == nil)
        return @"";
    
    if ([[aTableColumn identifier] isEqualToString:@"dateColumn"]) {
        
        NSArray *tasks = [project sortedTasks];
        Task *tarea = [tasks objectAtIndex:rowIndex];
        return [[tarea openDt] description];
        
    } else if ([[aTableColumn identifier] isEqualToString:@"titleColumn"]) {
        
        NSArray *tasks = [project sortedTasks];
        Task *tarea = [tasks objectAtIndex:rowIndex];
        return tarea.title;
        
    } else if ([[aTableColumn identifier] isEqualToString:@"stateColumn"]) {
        
        NSArray *tasks = [project sortedTasks];
        Task *tarea = [tasks objectAtIndex:rowIndex];
        NSNumber *num = tarea.state;
        if ([num intValue] == 0) return @"Open";
        else if ([num intValue] == 1) return @"Working";
        else return @"Closed"; //2
        
    } else if ([[aTableColumn identifier] isEqualToString:@"svnColumn"]) {
        
        NSArray *tasks = [project sortedTasks];
        Task *tarea = [tasks objectAtIndex:rowIndex];
        return tarea.svn;
        
    } else if ([[aTableColumn identifier] isEqualToString:@"devColumn"]) {
        
        NSArray *tasks = [project sortedTasks];
        Task *tarea = [tasks objectAtIndex:rowIndex];
        return tarea.dev;
        
    } else if ([[aTableColumn identifier] isEqualToString:@"certColumn"]) {
        
        NSArray *tasks = [project sortedTasks];
        Task *tarea = [tasks objectAtIndex:rowIndex];
        return tarea.cert;
        
    } else {//if ([[aTableColumn identifier] isEqualToString:@"releasColumn"]) {
        
        NSArray *tasks = [project sortedTasks];
        Task *tarea = [tasks objectAtIndex:rowIndex];
        return tarea.reles;
        
    } 

}

//To edit data
- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    
    if ([[aTableColumn identifier] isEqualToString:@"dateColumn"]) {
        
        NSArray *tasks = [project sortedTasks];
        Task *tarea = [tasks objectAtIndex:rowIndex];
        tarea.openDt = anObject;
        
            
    } else if ([[aTableColumn identifier] isEqualToString:@"titleColumn"]) {
        
        NSArray *tasks = [project sortedTasks];
        Task *tarea = [tasks objectAtIndex:rowIndex];
        tarea.title = anObject;
        
    } else if ([[aTableColumn identifier] isEqualToString:@"stateColumn"]) {
        
        NSArray *tasks = [project sortedTasks];
        Task *tarea = [tasks objectAtIndex:rowIndex];
        
        NSString *value = anObject;
        if ([value isEqualToString:@"Open"])
            tarea.state = [[[NSNumber alloc] initWithInt:0] autorelease];
        else if ([value isEqualToString:@"Working"])
            tarea.state = [[[NSNumber alloc] initWithInt:1] autorelease];
        else tarea.state = [[[NSNumber alloc] initWithInt:2] autorelease];
        
    } else if ([[aTableColumn identifier] isEqualToString:@"svnColumn"]) {
        
        NSArray *tasks = [project sortedTasks];
        Task *tarea = [tasks objectAtIndex:rowIndex];
        tarea.svn = anObject;
        
    } else if ([[aTableColumn identifier] isEqualToString:@"devColumn"]) {
        
        NSArray *tasks = [project sortedTasks];
        Task *tarea = [tasks objectAtIndex:rowIndex];
        tarea.dev = anObject;
        
    } else if ([[aTableColumn identifier] isEqualToString:@"certColumn"]) {
        
        NSArray *tasks = [project sortedTasks];
        Task *tarea = [tasks objectAtIndex:rowIndex];
        tarea.cert = anObject;
        
    } else {//if ([[aTableColumn identifier] isEqualToString:@"releasColumn"]) {
        
        NSArray *tasks = [project sortedTasks];
        Task *tarea = [tasks objectAtIndex:rowIndex];
        tarea.reles = anObject;
        
    } 

    
}

@end
