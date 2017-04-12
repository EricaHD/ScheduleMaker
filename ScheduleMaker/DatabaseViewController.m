//
//  DatabaseViewController.m
//  ScheduleMaker
//
//  Created by Erica Dominic on 3/11/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import "DatabaseViewController.h"
#import "StaffTableCellView.h"
#import "AddEditStaffViewController.h"
#import "StaffMember.h"

// Be able to drag rows
#define MyPrivateTableViewDataType @"MyPrivateTableViewDataType"

@interface DatabaseViewController ()

@property NSWindowController *myController;

// Add, delete, and edit staff member entries
- (IBAction)addStaff:(id)sender;
- (IBAction)editStaff:(id)sender;
- (IBAction)deleteStaff:(id)sender;

@end

@implementation DatabaseViewController

#pragma mark View Loading Methods ##############################################

// Do any additional setup after loading the view
- (void)viewDidLoad {
	
	// Super
	[super viewDidLoad];
	
	// Set row dimension, column dimensions, and column titles
	self.table.rowHeight = ROW_HEIGHT_3;
	NSArray *columns = self.table.tableColumns;
	for (int i = 0; i < columns.count; i++) {
		NSTableColumn *col = columns[i];
		if ([col.identifier isEqualToString:@"staff_col"]) {
			col.width = 700.0;
		}
	}
	
	// Reload table
	[self.table reloadData];
	
	// Listen for notification telling DatabaseViewController to reload table
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveReloadNotification:) name:@"NeedDatabaseTableReload" object:nil];
	
}

// Do any additional setup once the view is fully transitioned onto the screen
- (void)viewDidAppear {
	
	// Super
	[super viewDidAppear];
	
}

#pragma mark NSTableViewDelegate, NSTableViewDataSource Methods ################

// If notification telling DatabaseViewController to reload table is heard, do this:
- (void)receiveReloadNotification:(NSNotification *) notification {
	
	if ([[notification name] isEqualToString:@"NeedDatabaseTableReload"]) {
		[self.table reloadData];
	}
	
}

// Returns the number of records managed for a TableView by the data source object
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
	
	return [StaffMember getNumberOfEntries];
	
}

// Provides the table with the view to display in the cell at a specific column and row; also populates that cell with the appropriate data
// Different from -(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	
	NSArray *staffMembers = [StaffMember getContentsOfDatabase];
	
	// Define cells in first (and only) column
	if ([tableColumn.identifier isEqualToString:@"staff_col"]) {
		StaffTableCellView *cell = (StaffTableCellView *) [tableView makeViewWithIdentifier:@"staff_cell" owner:self];
		NSDictionary *staffMemberEntry = staffMembers[row];
		[cell.name setStringValue:staffMemberEntry[@"name"]];
		[cell.trike setState:[staffMemberEntry[@"trike"] integerValue]];
		[cell.coro setState:[staffMemberEntry[@"coro"] integerValue]];
		[cell.negOne setState:[staffMemberEntry[@"negOne"] integerValue]];
		[cell.zero setState:[staffMemberEntry[@"zero"] integerValue]];
		[cell.gallery setState:[staffMemberEntry[@"gallery"] integerValue]];
		[cell.floating setState:[staffMemberEntry[@"floating"] integerValue]];
		[cell.project setState:[staffMemberEntry[@"project"] integerValue]];
		[cell.greeting setState:[staffMemberEntry[@"greeting"] integerValue]];
		[cell.security setState:[staffMemberEntry[@"security"] integerValue]];
		[cell.tours setState:[staffMemberEntry[@"tours"] integerValue]];
		[cell.lesson setState:[staffMemberEntry[@"lesson"] integerValue]];
		[cell.manager setState:[staffMemberEntry[@"manager"] integerValue]];
		[cell.birthday setState:[staffMemberEntry[@"birthday"] integerValue]];
		[cell.other setState:[staffMemberEntry[@"other"] integerValue]];
		[cell.fireguard setState:[staffMemberEntry[@"fireguard"] integerValue]];
		[cell.trike setEnabled:NO];
		[cell.coro setEnabled:NO];
		[cell.negOne setEnabled:NO];
		[cell.zero setEnabled:NO];
		[cell.gallery setEnabled:NO];
		[cell.floating setEnabled:NO];
		[cell.project setEnabled:NO];
		[cell.greeting setEnabled:NO];
		[cell.security setEnabled:NO];
		[cell.tours setEnabled:NO];
		[cell.lesson setEnabled:NO];
		[cell.manager setEnabled:NO];
		[cell.birthday setEnabled:NO];
		[cell.other setEnabled:NO];
		[cell.fireguard setEnabled:NO];
		return cell;
	}
	
	// Otherwise
	else {
		return nil;
	}
	
}

#pragma mark Add Staff, Edit Staff, and Delete Staff Buttons ###################

// Adds staff member entry via presenting a new window via which to enter data
- (IBAction)addStaff:(id)sender {
	
	// Ready add/edit staff window that will be used in DatabaseViewController
	NSStoryboard *storyBoard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
	self.myController = [storyBoard instantiateControllerWithIdentifier:@"secondWindowController"];
	self.myController.window.title = @"Staff Member Qualifications";
	AddEditStaffViewController *addEditVC = (AddEditStaffViewController *) self.myController.contentViewController;
	
	// In new window, show empty fields for staff member name and qualifications
	addEditVC.name.stringValue = @"";
	addEditVC.trike.state = NSOffState;
	addEditVC.coro.state = NSOffState;
	addEditVC.negOne.state = NSOffState;
	addEditVC.zero.state = NSOffState;
	addEditVC.gallery.state = NSOffState;
	addEditVC.floating.state = NSOffState;
	addEditVC.project.state = NSOffState;
	addEditVC.greeting.state = NSOffState;
	addEditVC.security.state = NSOffState;
	addEditVC.tours.state = NSOffState;
	addEditVC.lesson.state = NSOffState;
	addEditVC.manager.state = NSOffState;
	addEditVC.birthday.state = NSOffState;
	addEditVC.other.state = NSOffState;
	addEditVC.fireguard.state = NSOffState;
	
	// Set row to edit property to -1 (because we are adding a new row)
	addEditVC.rowToEdit = -1;
	
	// Set save button label to "change"
	addEditVC.saveButton.title = @"Save";
	
	// Point AddEditStaffViewController toward model that all view controllers are using
	addEditVC.model = self.model;
	
	// Show window
	[self.myController showWindow:self];
	
}

// Edits selected staff member entry
- (IBAction)editStaff:(id)sender {
	
	// Find selected row (if there is one)
	NSInteger rowToEdit = [self.table selectedRow];
	if (rowToEdit == -1) {
		return;
	}
	
	// Ready add/edit staff window that will be used in DatabaseViewController
	NSStoryboard *storyBoard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
	self.myController = [storyBoard instantiateControllerWithIdentifier:@"secondWindowController"];
	self.myController.window.title = @"Staff Member Qualifications";
	AddEditStaffViewController *addEditVC = (AddEditStaffViewController *) self.myController.contentViewController;
	
	// Get cell and staff member name in that row
	StaffTableCellView *cell = (StaffTableCellView *) [self.table viewAtColumn:0 row:rowToEdit makeIfNecessary:NO];
	NSString *name = cell.name.stringValue;
	
	// In new window, fill in already recorded staff member name and qualifications
	StaffMember *staffMemberEntity = [StaffMember searchStaffMembersByName:name];
	addEditVC.name.stringValue = staffMemberEntity.name;
	[addEditVC.name setEditable:NO];
	addEditVC.trike.state = [staffMemberEntity.trike integerValue];
	addEditVC.coro.state = [staffMemberEntity.coro integerValue];
	addEditVC.negOne.state = [staffMemberEntity.negOne integerValue];
	addEditVC.zero.state = [staffMemberEntity.zero integerValue];
	addEditVC.gallery.state = [staffMemberEntity.gallery integerValue];
	addEditVC.floating.state = [staffMemberEntity.floating integerValue];
	addEditVC.project.state = [staffMemberEntity.project integerValue];
	addEditVC.greeting.state = [staffMemberEntity.greeting integerValue];
	addEditVC.security.state = [staffMemberEntity.security integerValue];
	addEditVC.tours.state = [staffMemberEntity.tours integerValue];
	addEditVC.lesson.state = [staffMemberEntity.lesson integerValue];
	addEditVC.manager.state = [staffMemberEntity.manager integerValue];
	addEditVC.birthday.state = [staffMemberEntity.birthday integerValue];
	addEditVC.other.state = [staffMemberEntity.other integerValue];
	addEditVC.fireguard.state = [staffMemberEntity.fireguard integerValue];
	
	// Set row to edit property
	addEditVC.rowToEdit = rowToEdit;
	
	// Set save button label to "change"
	addEditVC.saveButton.title = @"Change";
	
	// Point AddEditStaffViewController toward model that all view controllers are using
	addEditVC.model = self.model;
	
	// Show window
	[self.myController showWindow:self];
	
}

// Deletes selected staff member entry
- (IBAction)deleteStaff:(id)sender {
	
	// Find selected row (if there is one)
	NSInteger rowToDelete = [self.table selectedRow];
	if (rowToDelete == -1) {
		return;
	}
	
	// Get cell and staff member name in that row
	StaffTableCellView *cell = (StaffTableCellView *) [self.table viewAtColumn:0 row:rowToDelete makeIfNecessary:NO];
	NSString *name = cell.name.stringValue;
	
	// Remove selected staff member
	[StaffMember deleteStaffMemberWithName:name];
	
	// Reload table
	[self.table reloadData];
	
}

@end