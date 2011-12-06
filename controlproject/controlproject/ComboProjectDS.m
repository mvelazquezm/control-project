//
//  ComboProjectDS.m
//  controlproject
//
//  Created by Mario Velázquez Muñoz on 12/08/11.
//  Copyright 2011 Casa. All rights reserved.
//

#import "ComboProjectDS.h"

@implementation ComboProjectDS

@synthesize projects;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

// ==========================================================
// Combo box data source methods
// ==========================================================

- (NSInteger)numberOfItemsInComboBox:(NSComboBox *)aComboBox {
    return [projects count];
}
- (id)comboBox:(NSComboBox *)aComboBox objectValueForItemAtIndex:(NSInteger)loc {
   
    return [[projects objectAtIndex:loc] name];
}

- (NSUInteger)comboBox:(NSComboBox *)aComboBox indexOfItemWithStringValue:(NSString *)string {
    
    for (Project *p in projects) {
        if ([[p name] isEqualToString:string]) {
            return [projects indexOfObject:p];
        }
    }
    
    return 0;
}

-(Project *) getSelectedProjectOfcomoboBox:(NSComboBox *)aComboBox {
    
    //NSLog(@"El indice seleccionado es: %ld", [aComboBox indexOfSelectedItem]);
    
    if ([aComboBox indexOfSelectedItem] != -1)
        return [projects objectAtIndex: [aComboBox indexOfSelectedItem]];
    else
        return nil;
}

-(void) addProjectsObject:(Project *)object {
    [projects addObject:object];
}

-(void) removeProjectsObject:(Project *)object {
    [projects removeObject:object];
}




@end
