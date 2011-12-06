//
//  TableChangeDS.m
//  controlproject
//
//  Created by Mario Velázquez Muñoz on 01/09/11.
//  Copyright 2011 Casa. All rights reserved.
//

#import "TableChangeDS.h"

#import "Change.h"

@implementation TableChangeDS

@synthesize task;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        task = nil;
    }
    
    return self;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    if (task == nil)
        return 0;
    else
        return [[task changes] count]; 
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex {
    
    if (task == nil)
        return @"";
    
    if ([[aTableColumn identifier] isEqualToString:@"changeColumn"]) {
        
        NSArray *changes = [task sortedChanges];
        Change *cambio = [changes objectAtIndex:rowIndex];
        return cambio.title;
        
    } else { //if ([[aTableColumn identifier] isEqualToString:@"didColumn"]) {
        
        NSArray *changes = [task sortedChanges];
        Change *cambio = [changes objectAtIndex:rowIndex];
        return cambio.didit;
        
    } 
    
}

- (void)tableView:(NSTableView *)aTableView setObjectValue:(id)anObject forTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex
{
    
    if ([[aTableColumn identifier] isEqualToString:@"didColumn"]) {
        
        NSArray *changes = [task sortedChanges];
        Change *cambio = [changes objectAtIndex:rowIndex];
        cambio.didit = anObject;
        
    } else {
        
        NSArray *changes = [task sortedChanges];
        Change *cambio = [changes objectAtIndex:rowIndex];
        cambio.title = anObject;
    }
    
    
}









@end

