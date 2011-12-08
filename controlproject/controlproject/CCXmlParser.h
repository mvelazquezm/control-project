//
//  CCXmlParser.h
//  controlproject
//
//  Created by Mario Velázquez Muñoz on 04/12/11.
//  Copyright 2011 Casa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCXmlParser : NSObject


- (NSString *) makeXmlFromCoreData : (NSArray *) data;

- (NSString *) makeXmlFromCoreData : (NSManagedObjectContext *) context fetch : (NSFetchRequest *) request;

@end
