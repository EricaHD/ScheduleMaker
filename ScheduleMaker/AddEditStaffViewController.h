//
//  AddEditStaffViewController.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 3/26/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Model.h"

@interface AddEditStaffViewController : NSViewController

// Staff member name and qualification
@property (strong) IBOutlet NSTextField *name;
@property (strong) IBOutlet NSButton *trike;
@property (strong) IBOutlet NSButton *coro;
@property (strong) IBOutlet NSButton *negOne;
@property (strong) IBOutlet NSButton *zero;
@property (strong) IBOutlet NSButton *gallery;
@property (strong) IBOutlet NSButton *floating;
@property (strong) IBOutlet NSButton *project;
@property (strong) IBOutlet NSButton *greeting;
@property (strong) IBOutlet NSButton *security;
@property (strong) IBOutlet NSButton *tours;
@property (strong) IBOutlet NSButton *lesson;
@property (strong) IBOutlet NSButton *manager;
@property (strong) IBOutlet NSButton *birthday;
@property (strong) IBOutlet NSButton *other;
@property (strong) IBOutlet NSButton *fireguard;

// Outlet for save button (so we can change label)
@property (strong) IBOutlet NSButton *saveButton;

// Row to edit (set by DatabaseViewController to -1 when adding new row)
@property NSInteger rowToEdit;

// Reference to model that all view controllers will use
@property (strong) Model *model;

@end