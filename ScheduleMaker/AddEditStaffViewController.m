//
//  AddEditStaffViewController.m
//  ScheduleMaker
//
//  Created by Erica Dominic on 3/26/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import "AddEditStaffViewController.h"

@interface AddEditStaffViewController ()

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

// Cancel and save button
- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end

@implementation AddEditStaffViewController

// Do view setup here
- (void)viewDidLoad {

	// Super
	[super viewDidLoad];
	
}

// Cancel button (should not add any entered data, just close window)
- (IBAction)cancel:(id)sender {
	
	// Close window
	[self.view.window close];
	
}

// Save button should add data to staff dictionary, then close window
- (IBAction)save:(id)sender {
	
	// Make array of qualifications
	NSMutableArray *qualifications = [[NSMutableArray alloc] initWithCapacity:15];
	qualifications[0] = (self.trike.state) ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0];
	qualifications[1] = (self.coro.state) ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0];
	qualifications[2] = (self.negOne.state) ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0];
	qualifications[3] = (self.zero.state) ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0];
	qualifications[4] = (self.gallery.state) ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0];
	qualifications[5] = (self.floating.state) ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0];
	qualifications[6] = (self.project.state) ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0];
	qualifications[7] = (self.greeting.state) ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0];
	qualifications[8] = (self.security.state) ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0];
	qualifications[9] = (self.tours.state) ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0];
	qualifications[10] = (self.lesson.state) ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0];
	qualifications[11] = (self.manager.state) ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0];
	qualifications[12] = (self.birthday.state) ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0];
	qualifications[13] = (self.other.state) ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0];
	qualifications[14] = (self.fireguard.state) ? [NSNumber numberWithInt:1] : [NSNumber numberWithInt:0];

	// Call save method in model with parameters = above data
	[self.model save:self.name.stringValue withQualifications:qualifications];
	
	// Send notification telling DatabaseViewController to reload table now that new staff member has been added
	[[NSNotificationCenter defaultCenter] postNotificationName:@"NeedDatabaseTableReload" object:self];
	
	// Close window
	[self.view.window close];
	
}

@end