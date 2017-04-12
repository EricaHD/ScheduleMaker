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
	
	// Alter arrays in model using entered data
	if ([sender.title isEqualToString:@"Save"]) {
		[StaffMember addStaffMemberFromDictionary:staffMemberInfo];
	}
	else { // [sender.title isEqualToString:@"Change"]
		[StaffMember editStaffMemberFromDictionary:staffMemberInfo];
	}
	
	// Send notification telling DatabaseViewController to reload table now that new staff member has been added
	[[NSNotificationCenter defaultCenter] postNotificationName:@"NeedDatabaseTableReload" object:self];
	
	// Close window
	[self.view.window close];
	
}

@end