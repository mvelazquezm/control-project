//
//  ComboProjectDS.h
//  controlproject
//
//  Created by Mario Velázquez Muñoz on 12/08/11.
//  Copyright 2011 Casa. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Project.h"

@interface ComboProjectDS : NSObject <NSComboBoxDataSource> {
    @private

    NSMutableArray *projects;
}

@property (retain, readwrite) NSMutableArray *projects;

-(Project *) getSelectedProjectOfcomoboBox:(NSComboBox *)aComboBox;

-(void) addProjectsObject:(Project *)object;

-(void) removeProjectsObject:(Project *)object;

@end
