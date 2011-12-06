//
//  TableTaskDS.h
//  controlproject
//
//  Created by Mario Velázquez Muñoz on 17/08/11.
//  Copyright 2011 Casa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Project.h"

@interface TableTaskDS : NSObject <NSTableViewDataSource> {
    @private
    
    Project *project;
}

@property (retain, readwrite) Project *project;


@end
