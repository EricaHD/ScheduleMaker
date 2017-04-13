//
//  AddEditStaffViewController.m
//  ScheduleMaker
//
//  Created by Erica Dominic on 3/26/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import "AddEditStaffViewController.h"
#import "StaffMember.h"

@interface AddEditStaffViewController ()

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
- (IBAction)save:(NSButton *)sender {
	
	NSDictionary *staffMemberInfo = @{@"name": self.name.stringValue,
									  @"trike": (self.trike.state) ? @YES : @NO,
									  @"coro": (self.coro.state) ? @YES : @NO,
									  @"negOne": (self.negOne.state) ? @YES : @NO,
									  @"zero": (self.zero.state) ? @YES : @NO,
									  @"gallery": (self.gallery.state) ? @YES : @NO,
									  @"floating": (self.floating.state) ? @YES : @NO,
									  @"project": (self.project.state) ? @YES : @NO,
									  @"greeting": (self.greeting.state) ? @YES : @NO,
									  @"security": (self.security.state) ? @YES : @NO,
									  @"tours": (self.tours.state) ? @YES : @NO,
									  @"lesson": (self.lesson.state) ? @YES : @NO,
									  @"manager": (self.manager.state) ? @YES : @NO,
									  @"birthday": (self.birthday.state) ? @YES : @NO,
									  @"other": (self.other.state) ? @YES : @NO,
									  @"fireguard": (self.fireguard.state) ? @YES : @NO};
	
	// Add staff member, send notification telling DatabaseViewController to reload table, close window
	if ([sender.title isEqualToString:@"Save"]) {
		int result = [StaffMember addStaffMemberFromDictionary:staffMemberInfo];
		// If result is -1, show alert because staff member with that name already exists in database
		if (result == -1) {
			NSAlert *alert = [[NSAlert alloc] init];
			[alert addButtonWithTitle:@"OK"];
			[alert setMessageText:@"Identifier already in use"];
			[alert setInformativeText:@"Staff members are identified uniquely by their names. Please make sure each staff member is associated with a different name in the database."];
			[alert setAlertStyle:NSInformationalAlertStyle];
			NSWindow *window = [[NSApplication sharedApplication] mainWindow];
			[alert beginSheetModalForWindow:window completionHandler:nil];
		}
		else {
			[[NSNotificationCenter defaultCenter] postNotificationName:@"NeedDatabaseTableReload" object:self];
			[self.view.window close];
		}
	}
	
	// Edit staff member, send notification telling DatabaseViewController to reload table, close window
	else { // [sender.title isEqualToString:@"Change"]
		[StaffMember editStaffMemberFromDictionary:staffMemberInfo];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"NeedDatabaseTableReload" object:self];
		[self.view.window close];
	}
	
}

@end