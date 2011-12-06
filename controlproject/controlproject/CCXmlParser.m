//
//  CCXmlParser.m
//  controlproject
//
//  Created by Mario Velázquez Muñoz on 04/12/11.
//  Copyright 2011 Casa. All rights reserved.
//

//  This auxiliar class makes xml files from application core data and init core data 
//  with a xml file.

#import "CCXmlParser.h"

#import "Project.h"

@implementation CCXmlParser

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (NSString *) makeXmlFromCoreData : (NSArray *) data {
    
    NSLog(@"Entra makeXmlFromCoreData");
    
    
    NSMutableString * xml = [NSMutableString stringWithString:@"<controlproject>\n"];
    
    for (Project *auxProj in data) {
        
        //Head of the project
        [xml appendFormat:@"\t<project name=\"%@\">\n", auxProj.name];
        
        
        //End of the project
        [xml appendFormat:@"\t</project>\n"];
        
        
    } //end of for
    
    [xml appendString:@"</controlproject>"];
    
    
    return xml;

}

@end
