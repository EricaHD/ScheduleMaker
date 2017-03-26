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

@interface DatabaseViewController ()

@property NSWindowController *myController;

// Add, delete, and edit staff member entries
- (IBAction)addStaff:(id)sender;
- (IBAction)editStaff:(id)sender;
- (IBAction)deleteStaff:(id)sender;

@end

@implementation DatabaseViewController

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

// If notification telling DatabaseViewController to reload table is heard, do this:
- (void) receiveReloadNotification:(NSNotification *) notification {
	
	if ([[notification name] isEqualToString:@"NeedDatabaseTableReload"]) {
		[self.table reloadData];
	}
	
}

// Do any additional setup once the view is fully transitioned onto the screen
- (void)viewDidAppear {
	
	// Super
	[super viewDidAppear];
	
}

// Returns the number of records managed for a TableView by the data source object
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
	
	return self.model.staffNames.count;
	
}

// Provides the table with the view to display in the cell at a specific column and row; also populates that cell with the appropriate data
// Different from -(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	
	// Define cells in first (and only) column
	if ([tableColumn.identifier isEqualToString:@"staff_col"]) {
		StaffTableCellView *cell = (StaffTableCellView *) [tableView makeViewWithIdentifier:@"staff_cell" owner:self];
		[cell.name setStringValue:[NSString stringWithFormat:@"%@", self.model.staffNames[row]]];
		[cell.trike setState:[self.model.staffQualifications[row][0] integerValue]];
		[cell.trike setEnabled:NO];
		[cell.coro setState:[self.model.staffQualifications[row][1] integerValue]];
		[cell.coro setEnabled:NO];
		[cell.negOne setState:[self.model.staffQualifications[row][2] integerValue]];
		[cell.negOne setEnabled:NO];
		[cell.zero setState:[self.model.staffQualifications[row][3] integerValue]];
		[cell.zero setEnabled:NO];
		[cell.gallery setState:[self.model.staffQualifications[row][4] integerValue]];
		[cell.gallery setEnabled:NO];
		[cell.floating setState:[self.model.staffQualifications[row][5] integerValue]];
		[cell.floating setEnabled:NO];
		[cell.project setState:[self.model.staffQualifications[row][6] integerValue]];
		[cell.project setEnabled:NO];
		[cell.greeting setState:[self.model.staffQualifications[row][7] integerValue]];
		[cell.greeting setEnabled:NO];
		[cell.security setState:[self.model.staffQualifications[row][8] integerValue]];
		[cell.security setEnabled:NO];
		[cell.tours setState:[self.model.staffQualifications[row][9] integerValue]];
		[cell.tours setEnabled:NO];
		[cell.lesson setState:[self.model.staffQualifications[row][10] integerValue]];
		[cell.lesson setEnabled:NO];
		[cell.manager setState:[self.model.staffQualifications[row][11] integerValue]];
		[cell.manager setEnabled:NO];
		[cell.birthday setState:[self.model.staffQualifications[row][12] integerValue]];
		[cell.birthday setEnabled:NO];
		[cell.other setState:[self.model.staffQualifications[row][13] integerValue]];
		[cell.other setEnabled:NO];
		[cell.fireguard setState:[self.model.staffQualifications[row][14] integerValue]];
		[cell.fireguard setEnabled:NO];
		return cell;
	}
	
	// Otherwise
	else {
		return nil;
	}
	
}

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
	
	// In new window, fill in already recorded staff member name and qualifications
	addEditVC.name.stringValue = self.model.staffNames[rowToEdit];
	addEditVC.trike.state = ([self.model.staffQualifications[rowToEdit][0] integerValue]) ? NSOnState : NSOffState;
	addEditVC.coro.state = ([self.model.staffQualifications[rowToEdit][1] integerValue]) ? NSOnState : NSOffState;
	addEditVC.negOne.state = ([self.model.staffQualifications[rowToEdit][2] integerValue]) ? NSOnState : NSOffState;
	addEditVC.zero.state = ([self.model.staffQualifications[rowToEdit][3] integerValue]) ? NSOnState : NSOffState;
	addEditVC.gallery.state = ([self.model.staffQualifications[rowToEdit][4] integerValue]) ? NSOnState : NSOffState;
	addEditVC.floating.state = ([self.model.staffQualifications[rowToEdit][5] integerValue]) ? NSOnState : NSOffState;
	addEditVC.project.state = ([self.model.staffQualifications[rowToEdit][6] integerValue]) ? NSOnState : NSOffState;
	addEditVC.greeting.state = ([self.model.staffQualifications[rowToEdit][7] integerValue]) ? NSOnState : NSOffState;
	addEditVC.security.state = ([self.model.staffQualifications[rowToEdit][8] integerValue]) ? NSOnState : NSOffState;
	addEditVC.tours.state = ([self.model.staffQualifications[rowToEdit][9] integerValue]) ? NSOnState : NSOffState;
	addEditVC.lesson.state = ([self.model.staffQualifications[rowToEdit][10] integerValue]) ? NSOnState : NSOffState;
	addEditVC.manager.state = ([self.model.staffQualifications[rowToEdit][11] integerValue]) ? NSOnState : NSOffState;
	addEditVC.birthday.state = ([self.model.staffQualifications[rowToEdit][12] integerValue]) ? NSOnState : NSOffState;
	addEditVC.other.state = ([self.model.staffQualifications[rowToEdit][13] integerValue]) ? NSOnState : NSOffState;
	addEditVC.fireguard.state = ([self.model.staffQualifications[rowToEdit][14] integerValue]) ? NSOnState : NSOffState;
	
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
	
	// Remove selected entry from self.model.staffNames and self.model.staffQualifications
	[self.model.staffNames removeObjectAtIndex:rowToDelete];
	[self.model.staffQualifications removeObjectAtIndex:rowToDelete];
	
	// Reload table
	[self.table reloadData];
	
}

@end