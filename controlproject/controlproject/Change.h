//
//  Change.h
//  controlproject
//
//  Created by Mario Velázquez Muñoz on 08/08/11.
//  Copyright (c) 2011 Casa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Task;

@interface Change : NSManagedObject {
@private
}
@property (nonatomic, retain) NSNumber * didit;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) Task *task;

@end
