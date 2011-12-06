//
//  controlprojectAppDelegate.m
//  controlproject
//
//  Created by Mario Velázquez Muñoz on 18/07/11.
//  Copyright 2011 Casa. All rights reserved.
//

#import "controlprojectAppDelegate.h"

#import "Project.h"
#import "Task.h"
#import "Change.h"

@implementation controlprojectAppDelegate
@synthesize taskDescriptionF;
@synthesize tasksTable;
@synthesize taskDescriptionG;
@synthesize changeField;
@synthesize changesTable;
@synthesize historicText;
@synthesize taskTitleField;

@synthesize projectCombo;
@synthesize newTaskPanel;
@synthesize newChangePanel;
@synthesize historicPanel;
@synthesize window;
@synthesize newPanel;
@synthesize projectNameField;
@synthesize btUdateDetail;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    
    
    //Init proceess:
    //1.- Load Core Data Model  
    //2.- If there are projects, create TABs: NSTabView.
    //And add a tab for anyone
    
    NSLog(@"Entra en applicationDidFinishLaunching");
    
    NSError *error = nil;
    
    
    NSFetchRequest *fetchRequest = [self.managedObjectModel fetchRequestTemplateForName:@"FetchProjects"];
    
    //Ordering
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"name" ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    [sortDescriptor release];
    
    comboDataSource = [[ComboProjectDS alloc] init ];
    
    NSMutableArray *arrayOfProject = [[NSMutableArray alloc] initWithArray:[self.managedObjectContext executeFetchRequest:fetchRequest error:&error]];
    
   
    
       
    [comboDataSource setProjects:arrayOfProject];
    
    //NSLog(@"Projecto: %lu", [projects count]);
    //[projectCombo addItemsWithObjectValues:projects];
    
    //[projectCombo setDataSource:[comboDataSource retain]];
    [projectCombo setDataSource:comboDataSource];
    
    [arrayOfProject release];
    
    //set the table datasource
    tableDataSource = [[TableTaskDS alloc] init];
    [tasksTable setDataSource:tableDataSource];
    
    //Set the table of changes datasource
    tableChangeDataSource = [[TableChangeDS alloc] init];
    [changesTable setDataSource:tableChangeDataSource];

}

/**
    Returns the directory the application uses to store the Core Data store file. This code uses a directory named "controlproject" in the user's Library directory.
 */
- (NSURL *)applicationFilesDirectory {

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *libraryURL = [[fileManager URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject];
    return [libraryURL URLByAppendingPathComponent:@"controlproject"];
}

/**
    Creates if necessary and returns the managed object model for the application.
 */
- (NSManagedObjectModel *)managedObjectModel {
    if (__managedObjectModel) {
        return __managedObjectModel;
    }
	
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"controlproject" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];    
    return __managedObjectModel;
}

/**
    Returns the persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. (The directory for the store is created, if necessary.)
 */
- (NSPersistentStoreCoordinator *) persistentStoreCoordinator {
    if (__persistentStoreCoordinator) {
        return __persistentStoreCoordinator;
    }

    NSManagedObjectModel *mom = [self managedObjectModel];
    if (!mom) {
        NSLog(@"%@:%@ No model to generate a store from", [self class], NSStringFromSelector(_cmd));
        return nil;
    }

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *applicationFilesDirectory = [self applicationFilesDirectory];
    NSError *error = nil;
    
    NSDictionary *properties = [applicationFilesDirectory resourceValuesForKeys:[NSArray arrayWithObject:NSURLIsDirectoryKey] error:&error];
        
    if (!properties) {
        BOOL ok = NO;
        if ([error code] == NSFileReadNoSuchFileError) {
            ok = [fileManager createDirectoryAtPath:[applicationFilesDirectory path] withIntermediateDirectories:YES attributes:nil error:&error];
        }
        if (!ok) {
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    }
    else {
        if ([[properties objectForKey:NSURLIsDirectoryKey] boolValue] != YES) {
            // Customize and localize this error.
            NSString *failureDescription = [NSString stringWithFormat:@"Expected a folder to store application data, found a file (%@).", [applicationFilesDirectory path]]; 
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:failureDescription forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:101 userInfo:dict];
            
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    }
    
    NSURL *url = [applicationFilesDirectory URLByAppendingPathComponent:@"controlproject.storedata"];
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSXMLStoreType configuration:nil URL:url options:nil error:&error]) {
        [[NSApplication sharedApplication] presentError:error];
        [__persistentStoreCoordinator release], __persistentStoreCoordinator = nil;
        return nil;
    }

    return __persistentStoreCoordinator;
}

/**
    Returns the managed object context for the application (which is already
    bound to the persistent store coordinator for the application.) 
 */
- (NSManagedObjectContext *) managedObjectContext {
    if (__managedObjectContext) {
        return __managedObjectContext;
    }

    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:@"Failed to initialize the store" forKey:NSLocalizedDescriptionKey];
        [dict setValue:@"There was an error building up the data file." forKey:NSLocalizedFailureReasonErrorKey];
        NSError *error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    __managedObjectContext = [[NSManagedObjectContext alloc] init];
    [__managedObjectContext setPersistentStoreCoordinator:coordinator];

    return __managedObjectContext;
}

/**
    Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
 */
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window {
    return [[self managedObjectContext] undoManager];
}

/**
    Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
 */
- (IBAction) saveAction:(id)sender {
    NSError *error = nil;
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
    }

    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
    
    NSLog(@"Se cierra la aplicación, perfecto");
    //If there are closed and finished tasks, then we save it in text file, and delete from context.
    
    NSArray *projects = [comboDataSource projects];
    for (Project *p in projects) {
        for (Task *t in [[p tasks] allObjects]) {
            if ([t.state intValue] == 2 && [t.svn intValue] == 1 && [t.dev intValue] == 1 &&
                [t.cert intValue] == 1 && [t.reles intValue] == 1) {
                //Task is finished
                //t.closeDt = [[[NSDate alloc] init] autorelease];
                t.closeDt = [NSDate date];
                
                //Now write the task in text file, and delete task from coreDataManager
                NSMutableString *newText = [NSMutableString stringWithFormat:@"Project: %@\n\tTask: %@\n\tOpened: %@\n\tClosed: %@\n\tChanges: \n", p.name, t.title, t.openDt, t.closeDt];
                for (Change *ch in [[t changes] allObjects]) {
                    [newText appendFormat:@"\t\t%@\n", ch.title];
                }
                
                [newText appendString:@"--------------------------------------------------------\n\n"];
                
                //Now reads text file and appends newText NSMutableString
                NSStringEncoding    encoding = NSUTF8StringEncoding;
                NSError             *error = nil;
                
                //New changes
                NSURL *applicationFilesDirectory = [self applicationFilesDirectory];
                NSURL *url = [applicationFilesDirectory URLByAppendingPathComponent:@"historic.txt"];
                
                NSString *textFile = [NSString stringWithContentsOfURL:url encoding:encoding error:&error];
                //End new changes
                
                //NSString *textFile = [NSString stringWithContentsOfFile:@"historic.txt" encoding:encoding error:&error];
                if (textFile != nil)
                    [newText appendString:textFile];
                //[newText writeToFile:@"historic.txt" atomically:YES encoding:encoding error:&error];
                //New changes
                [newText writeToURL:url atomically:YES encoding:encoding error:&error];
                
                //deletes the task
                [__managedObjectContext deleteObject:t];
            }
        }
    }
    
    

    // Save changes in the application's managed object context before the application terminates.

    if (!__managedObjectContext) {
        return NSTerminateNow;
    }

    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd));
        return NSTerminateCancel;
    }

    if (![[self managedObjectContext] hasChanges]) {
        return NSTerminateNow;
    }

    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {

        // Customize this code block to include application-specific recovery steps.              
        BOOL result = [sender presentError:error];
        if (result) {
            return NSTerminateCancel;
        }

        NSString *question = NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];

        NSInteger answer = [alert runModal];
        [alert release];
        alert = nil;
        
        if (answer == NSAlertAlternateReturn) {
            return NSTerminateCancel;
        }
    }

    return NSTerminateNow;
}

- (void)dealloc
{
    [__managedObjectContext release];
    [__persistentStoreCoordinator release];
    [__managedObjectModel release];
    [comboDataSource release];
    [tableDataSource release];
    [tableChangeDataSource release];
    [super dealloc];
}

//-------------------------------------------------------------------------------------
// PERSONAL METHODS
//-------------------------------------------------------------------------------------



/** 
 Open a panel to create a new project
 */
-(IBAction)newProject:(id)sender {
    //It should open a new Window with textfield to record the new Project NAME
    //and open a new tab for the project in the NSTabView.
    [newPanel makeKeyAndOrderFront:nil];
    [projectNameField setStringValue:@""];
} //End of newProject Action

/**
 * Creates the new project
 */
-(IBAction)createNewProject:(id)sender {
    //We take the project name and save it in our Data Model.
    //We have to put a new NSTab for the project, if there aren´t any project
    NSLog(@"Lo hace correctamente");
    
    Project *project = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Project" 
                        inManagedObjectContext:__managedObjectContext];
    
    project.name = [projectNameField stringValue];
    
    NSError *error;
    
    if (![__managedObjectContext save:&error]) {
        NSLog(@"Error en la insercción");
    }
    
    [comboDataSource addProjectsObject:project];
    
    [newPanel close];
    
}

- (IBAction)newProjectButton:(id)sender {
    [newPanel makeKeyAndOrderFront:nil];
    [projectNameField setStringValue:@""];
}

- (IBAction)openHistoricWindow:(id)sender {
    [historicPanel makeKeyAndOrderFront:nil];
                          
    NSStringEncoding    encoding = NSUTF8StringEncoding;
    NSError             *error = nil;
    
    //New changes
    NSURL *applicationFilesDirectory = [self applicationFilesDirectory];
    NSURL *url = [applicationFilesDirectory URLByAppendingPathComponent:@"historic.txt"];
    
    NSString *textFile = [NSString stringWithContentsOfURL:url encoding:encoding error:&error];
    //End new changes
    
    //NSString *textFile = [NSString stringWithContentsOfFile:@"historic.txt" encoding:encoding error:&error];
    
    if (textFile != nil) {
        [historicText setString:textFile];
    } else {
        [historicText setString:@""];
    }
}

- (IBAction)updateDetail:(id)sender {
    if ([tasksTable selectedRow] != -1) {
        Project *prj = [tableDataSource project];
        NSArray *tasks = [prj sortedTasks];

        Task *taskToUpdate = [tasks objectAtIndex:[tasksTable selectedRow]];
        //[taskToUpdate setComment:[taskDescriptionG string]];
        
        taskToUpdate.comment = [[[NSString alloc] initWithString:[taskDescriptionG string]] autorelease];
        
        [btUdateDetail setEnabled:false];
    }
    
}

- (IBAction)deleteProject:(id)sender {
    //Deletes selected project, its tasks and its changes
    if ([projectCombo indexOfSelectedItem] != -1) {
        
        //We have put a NSAlert with OK/Cancel condition and delete de NSManagedObject
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"OK"];
        [alert addButtonWithTitle:@"Cancel"];
        [alert setMessageText:@"Delete the Project and its tasks and changes?"];
        [alert setInformativeText:@"Deleted Projects cannot be restored."];
        [alert setAlertStyle:NSWarningAlertStyle];
        
        if ([alert runModal] == NSAlertFirstButtonReturn) {
            // OK clicked, delete the record
            NSLog(@"Borramos Proyecto");
            
            Project *selectedProject = [comboDataSource getSelectedProjectOfcomoboBox:projectCombo];
            
            [__managedObjectContext deleteObject:selectedProject];
            
            NSError *error;
            
            if (![__managedObjectContext save:&error]) {
                NSLog(@"Error comitando el borrado");
            }
            
            [comboDataSource removeProjectsObject:selectedProject];
            [projectCombo setStringValue:@""];
            [projectCombo reloadData];
            [tableDataSource setProject:nil];
            [tasksTable reloadData];
            [tableChangeDataSource setTask:nil];
            [changesTable reloadData];
            
            
        }
        [alert release];
        
    }

}

- (IBAction)newTask:(id)sender {
    //Opens new task panel only if there are selected project in combobox
    if ([projectCombo indexOfSelectedItem] != -1) {
    
        [newTaskPanel makeKeyAndOrderFront:nil];
        [taskTitleField setStringValue:@""];
        [taskDescriptionF setString:@""];
    } else {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:@"You must select a project"];
        [alert setInformativeText:@"New tasks must be linked to a project."];
        [alert setAlertStyle:NSWarningAlertStyle];
        
        [alert runModal];
        [alert release];
    }
   
}

- (IBAction)delteTask:(id)sender {
    //Deteles selected task and its changes
    if ([tasksTable selectedRow] != -1) {
        
        //We have put a NSAlert with OK/Cancel condition and delete de NSManagedObject
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"OK"];
        [alert addButtonWithTitle:@"Cancel"];
        [alert setMessageText:@"Delete the task and its changes?"];
        [alert setInformativeText:@"Deleted task cannot be restored."];
        [alert setAlertStyle:NSWarningAlertStyle];
        
        if ([alert runModal] == NSAlertFirstButtonReturn) {
            // OK clicked, delete the record
            NSLog(@"Borramos Tarea");
            
            //NOTE: We take from change´s table... it can´t work properly...
            Task *taskToDelete = [tableChangeDataSource task];
            
            [__managedObjectContext deleteObject:taskToDelete];
            
            NSError *error;
            
            if (![__managedObjectContext save:&error]) {
                NSLog(@"Error comitando el borrado");
            }
            
            //[fatherTask orderChanges];
            [tasksTable reloadData];
            [tableChangeDataSource setTask:nil];
            [changesTable reloadData];
            
            
        }
        [alert release];
        
    }

}

- (IBAction)newChange:(id)sender {
    if ([projectCombo indexOfSelectedItem] != -1 &&
        [tasksTable selectedRow] != -1) {
        //Opens new change panel.
        [newChangePanel makeKeyAndOrderFront:nil];
        [changeField setStringValue:@""];
    } else {
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:@"You must select a project and a task"];
        [alert setInformativeText:@"New changes must be linked to a task."];
        [alert setAlertStyle:NSWarningAlertStyle];
        
        [alert runModal];
        [alert release];
    }
}

- (IBAction)deleteChange:(id)sender {
    //Deteles selected change
    if ([changesTable selectedRow] != -1) {
        //We have put a NSAlert with OK/Cancel condition and delete de NSManagedObject
        NSAlert *alert = [[NSAlert alloc] init];
        [alert addButtonWithTitle:@"OK"];
        [alert addButtonWithTitle:@"Cancel"];
        [alert setMessageText:@"Delete the change?"];
        [alert setInformativeText:@"Deleted changes cannot be restored."];
        [alert setAlertStyle:NSWarningAlertStyle];
        
        if ([alert runModal] == NSAlertFirstButtonReturn) {
            // OK clicked, delete the record
            //[self deleteRecord:currentRec];
            NSLog(@"Borramos Cambio");
            
            Task *fatherTask = [tableChangeDataSource task];
            NSArray *changesArray = [fatherTask sortedChanges];
            Change *toDeleteChange = [changesArray objectAtIndex:[changesTable selectedRow]];
            
            [__managedObjectContext deleteObject:toDeleteChange];
            
            NSError *error;
            
            if (![__managedObjectContext save:&error]) {
                NSLog(@"Error comitando el borrado");
            }
            
            [fatherTask orderChanges];
            [changesTable reloadData];
            
            
        }
        [alert release];
        
    }
}

- (IBAction)createChange:(id)sender {
    //Create the task...and close panel.
    NSLog(@"Creando un nuevo cambio");
    
    Change *newChange = [NSEntityDescription
                     insertNewObjectForEntityForName:@"Change" 
                     inManagedObjectContext:__managedObjectContext];
    
    newChange.title = [changeField stringValue];
    newChange.didit = 0;
    
    Project *prj = [tableDataSource project];
    NSArray *tasks = [prj sortedTasks];
    Task *tarea = [tasks objectAtIndex:[tasksTable selectedRow]];
    
    [tarea addChangesObject:[newChange retain]];
    [newChange release];
    
    NSError *error;
    
    if (![__managedObjectContext save:&error]) {
        NSLog(@"Error en la insercción");
    }
    
    [tarea orderChanges];
    
    [changesTable reloadData];
    
    [newChangePanel close];

}

- (IBAction)selectTask:(id)sender {
    NSLog(@"Seleccciona una tarea");
    //OK
    
    if ([tasksTable selectedRow] != -1) {
    
        //We search the project and selected tasks and we will put the task´s desctiption y the table.
        Project *prj = [tableDataSource project];
        NSArray *tasks = [prj sortedTasks];
        
        Task *tarea = [tasks objectAtIndex:[tasksTable selectedRow]];
        
        [tarea orderChanges];
        
        NSLog(@"LA tarea es: %@", tarea.title);
        NSLog(@"Tareacomment vale %@", tarea.comment);
    
        //[taskDescriptionG setString:tarea.comment];
        [taskDescriptionG setString:[tarea comment]];
        [btUdateDetail setEnabled:false];
        
        //And now we have to put all changes in the table
        [tableChangeDataSource setTask:tarea];
        [changesTable reloadData];
    }
    
}

/*
 it should load project´s tasks in a table.
 */
- (IBAction)changeProject:(id)sender {
    NSLog(@"Entra en change Project");
    
    Project *selectedProject = [comboDataSource getSelectedProjectOfcomoboBox:sender];
    
    if (selectedProject != nil) {
    
        [selectedProject orderTasks];
        [btUdateDetail setEnabled:false];
    
        [tableDataSource setProject:selectedProject];
        [tasksTable reloadData];
    }
    
    
}

- (IBAction)createTask:(id)sender {
    //Create the task...and close panel.
    NSLog(@"Funcionamiento de cierre");
    
    
    //We make new task, and add it to project
    //Task *newTask = [[Task alloc] init];
    Task *newTask = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Task" 
                        inManagedObjectContext:__managedObjectContext];
    
    newTask.title = [taskTitleField stringValue];
    newTask.openDt = [[[NSDate alloc] init] autorelease];
    newTask.cert = 0;
    newTask.svn = 0;
    newTask.reles = 0;
    newTask.state = 0;
    newTask.dev = 0;
    newTask.comment = [taskDescriptionF string];
    
    Project *selectedProject = [comboDataSource getSelectedProjectOfcomoboBox:projectCombo];
    
    [selectedProject addTasksObject:[newTask retain]];
    [newTask release];
    
    [btUdateDetail setEnabled:false];
    
    NSError *error;
    
    if (![__managedObjectContext save:&error]) {
        NSLog(@"Error en la insercción");
    }
    [selectedProject orderTasks];
    [tasksTable reloadData];
    
    [newTaskPanel close];
}

- (IBAction)resetHistoric:(id)sender {
    //We have put a NSAlert with OK/Cancel condition and delete de NSManagedObject
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"OK"];
    [alert addButtonWithTitle:@"Cancel"];
    [alert setMessageText:@"Reset historic?"];
    [alert setInformativeText:@"Reset historic can not be restored."];
    [alert setAlertStyle:NSWarningAlertStyle];
    
    if ([alert runModal] == NSAlertFirstButtonReturn) {
        // OK clicked
        NSStringEncoding    encoding = NSUTF8StringEncoding;
        NSError             *error = nil;
        //New changes
        NSURL *applicationFilesDirectory = [self applicationFilesDirectory];
        NSURL *url = [applicationFilesDirectory URLByAppendingPathComponent:@"historic.txt"];
        
        //NSString *textFile = [NSString stringWithContentsOfURL:url encoding:encoding error:&error];
        //End new changes
        //[@"" writeToFile:@"historic.txt" atomically:YES encoding:encoding error:&error];
        [@"" writeToURL:url atomically:YES encoding:encoding error:&error];
    }
    [alert release];

}

- (void)textDidChange:(NSNotification *)notification {
    if ([tasksTable selectedRow] != -1) {
        if (![btUdateDetail isEnabled]) {
            [btUdateDetail setEnabled:true];
        }
    }
}

- (IBAction)doSaveAs:(id)sender { 
    NSLog(@"doSaveAs"); 
    NSSavePanel *tvarNSSavePanelObj = [NSSavePanel savePanel]; 
    NSInteger tvarInt = [tvarNSSavePanelObj runModal]; 
    if(tvarInt == NSOKButton) { 
        NSLog(@"doSaveAs we have an OK button"); 
        
        //Now reads text file and appends newText NSMutableString
        NSStringEncoding    encoding = NSUTF8StringEncoding;
        NSError             *error = nil;
        //NSString *textFile = [NSString stringWithContentsOfFile:@"historic.txt" encoding:encoding error:&error];
        //New changes
        NSURL *applicationFilesDirectory = [self applicationFilesDirectory];
        NSURL *url = [applicationFilesDirectory URLByAppendingPathComponent:@"historic.txt"];
        
        NSString *textFile = [NSString stringWithContentsOfURL:url encoding:encoding error:&error];
        //End new change
        
        NSURL * urlExport = [tvarNSSavePanelObj URL];
        
        [textFile writeToURL:urlExport atomically:YES encoding:encoding error:&error];
    }
} // end doSaveAs

- (IBAction)doFullScreen:(id)sender {
    [window toggleFullScreen:nil];
}




@end
