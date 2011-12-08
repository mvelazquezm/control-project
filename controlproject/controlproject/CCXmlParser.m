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
#import "Task.h"
#import "Change.h"

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

- (NSString *) makeXmlFromCoreData : (NSManagedObjectContext *) context fetch : (NSFetchRequest *) request {
    
    NSError *error = nil;
    
    NSArray *arrayOfProject = [[NSArray alloc] initWithArray:[context executeFetchRequest:request error:&error]];
    
    NSMutableString * xml = [NSMutableString stringWithString:@"<controlproject>\n"];
    
    for (Project * auxProj in arrayOfProject) {
        //Head of the project
        [xml appendFormat:@"\t<project title=\"%@\">\n", auxProj.name];
        
        for (Task * auxTask in [auxProj.tasks allObjects]) {
            [xml appendFormat:@"\t\t<task>\n"];
            
            [xml appendFormat:@"\t\t\t<title>%@</title>\n", auxTask.title];
            [xml appendFormat:@"\t\t\t<cert>%d</cert>\n", [auxTask.cert intValue]];
            [xml appendFormat:@"\t\t\t<comment>%@</comment>\n", auxTask.comment];
            [xml appendFormat:@"\t\t\t<dev>%d</dev>\n", [auxTask.dev intValue]];
            [xml appendFormat:@"\t\t\t<reles>%d</reles>\n", [auxTask.reles intValue]];
            [xml appendFormat:@"\t\t\t<state>%d</state>\n", [auxTask.state intValue]];
            [xml appendFormat:@"\t\t\t<svn>%d</svn>\n", [auxTask.svn intValue]];
            //[xml appendFormat:@"\t\t\t<closeDt>%@</closeDt>\n", auxTask.closeDt];
            [xml appendFormat:@"\t\t\t<openDt>%@</openDt>\n", auxTask.openDt];
            
            [xml appendFormat:@"\t\t\t<changes>\n"];
            
            for (Change * auxChange in [auxTask.changes allObjects]) {
                [xml appendFormat:@"\t\t\t\t<change title=\"%@\">%d</change>\n", auxChange.title, [auxChange.didit intValue]];
            }
            
            
            [xml appendString:@"\t\t\t</changes>\n"];
            
            [xml appendString:@"\t\t</task>\n"];
            
            
        } //End of for tasks
        
        
        //End of the project
        [xml appendFormat:@"\t</project>\n"];
        
        
    } //end of for
    
    [xml appendString:@"</controlproject>"];
    
    
    //Pruebas
    
    NSXMLDocument *docXml;
    
    docXml = [[NSXMLDocument alloc] initWithXMLString:xml options:NSXMLDocumentTidyXML error:&error];
    
    NSArray * projects = [docXml nodesForXPath:@".//project" error:&error];
    
    for (NSXMLElement * element in projects) {
        NSLog(@"Venga: %@", [element attributeForName:@"title"]);
        
        NSString *str = [[element attributeForName:@"title"] stringValue];
        
        NSLog(@"%@", str);
        
        NSArray * tareas = [element nodesForXPath:@"./task" error:&error];
        
        for (NSXMLElement * eleTar in tareas) {
            
            NSString * title = [[eleTar attributeForName:@"title"] stringValue];
            
            NSXMLElement * eleTitle = [eleTar elementForName:@"title"];
            NSLog(@"%@", [[eleTitle value] stringValue]);
            
            NSLog(@"%@", title);
        }
        
        /*
         <project title="bla">
            <task title="bla" dev="0" rev="0" aso="1" ...>
                <change title="blaba" did="0"/>
                <change..>
            </task>
        </jproject>
            
         */
        

    }
    
    
    
    
    
    [docXml release];
    
    
    return xml;    
}

@end
