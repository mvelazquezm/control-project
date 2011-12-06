//
//  controlprojectAppDelegate.h
//  controlproject
//
//  Created by Mario Velázquez Muñoz on 18/07/11.
//  Copyright 2011 Casa. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "ComboProjectDS.h"
#import "TableTaskDS.h"
#import "TableChangeDS.h"

@interface controlprojectAppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *window;
    NSPersistentStoreCoordinator *__persistentStoreCoordinator;
    NSManagedObjectModel *__managedObjectModel;
    NSManagedObjectContext *__managedObjectContext;
    
    //Customs properties
    NSPanel *newPanel;
    
    
    ComboProjectDS *comboDataSource;
    TableTaskDS *tableDataSource;
    TableChangeDS *tableChangeDataSource;

    
    NSComboBox *projectCombo;
    NSPanel *newTaskPanel;
    NSPanel *newChangePanel;
    NSPanel *historicPanel;
    NSTextField *taskTitleField;
    NSTextView *taskDescriptionF;
    NSTableView *tasksTable;
    NSTextView *taskDescriptionG;
    NSTextField *changeField;
    NSTableView *changesTable;
    NSTextView *historicText;
    
    NSTextField * projectNameField;
    NSButton * btUdateDetail;
}

@property (assign) IBOutlet NSComboBox *projectCombo;
@property (assign) IBOutlet NSPanel *newTaskPanel;
@property (assign) IBOutlet NSPanel *newChangePanel;
@property (assign) IBOutlet NSPanel *historicPanel;
@property (assign) IBOutlet NSButton *btUdateDetail;

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSPanel *newPanel;
@property (assign) IBOutlet NSTextField *projectNameField;

@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (assign) IBOutlet NSTextField *taskTitleField;
@property (assign) IBOutlet NSTextView *taskDescriptionF;

@property (assign) IBOutlet NSTableView *tasksTable;
@property (assign) IBOutlet NSTextView *taskDescriptionG;
@property (assign) IBOutlet NSTextField *changeField;
@property (assign) IBOutlet NSTableView *changesTable;

@property (assign) IBOutlet NSTextView *historicText;

- (IBAction)saveAction:sender;
- (IBAction)newProject:(id)sender;

- (IBAction)createNewProject:(id)sender;

- (IBAction)newProjectButton:(id)sender;
- (IBAction)openHistoricWindow:(id)sender;
- (IBAction)updateDetail:(id)sender;

- (IBAction)deleteProject:(id)sender;
- (IBAction)newTask:(id)sender;
- (IBAction)delteTask:(id)sender;
- (IBAction)newChange:(id)sender;
- (IBAction)deleteChange:(id)sender;
- (IBAction)createChange:(id)sender;

- (IBAction)selectTask:(id)sender;

- (IBAction)changeProject:(id)sender;
- (IBAction)createTask:(id)sender;

- (IBAction)resetHistoric:(id)sender;
- (IBAction)doSaveAs:(id)sender;
- (IBAction)doFullScreen:(id)sender;



@end
