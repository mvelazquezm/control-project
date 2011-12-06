//
//  TableChangeDS.h
//  controlproject
//
//  Created by Mario Velázquez Muñoz on 01/09/11.
//  Copyright 2011 Casa. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Task.h"

@interface TableChangeDS : NSObject <NSTableViewDataSource> {
    @private
        
    Task *task;
}

@property (retain, readwrite) Task *task;

@end
