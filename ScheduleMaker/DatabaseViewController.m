//
//  DatabaseViewController.m
//  ScheduleMaker
//
//  Created by Erica Dominic on 3/11/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import "DatabaseViewController.h"
#import "StaffTableCellView.h"

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
		return cell;
	}
	
	// Otherwise
	else {
		return nil;
	}
	
}

// Adds staff member entry via presenting a new window via which to enter data
- (IBAction)addStaff:(id)sender {
	
	// TODO
	
	// Ready add/edit staff window that will be used in DatabaseViewController
	NSStoryboard *storyBoard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
	self.myController = [storyBoard instantiateControllerWithIdentifier:@"secondWindowController"];
	[self.myController showWindow:self];
	
}

// Edits selected staff member entry
- (IBAction)editStaff:(id)sender {
	
	// TODO
	
}

// Deletes selected staff member entry
- (IBAction)deleteStaff:(id)sender {
	
	// Find selected row
	NSInteger rowToDelete = [self.table selectedRow];
	
	// Remove selected entry from self.model.staffNames and self.model.staffQualifications
	[self.model.staffNames removeObjectAtIndex:rowToDelete];
	[self.model.staffQualifications removeObjectAtIndex:rowToDelete];
	
	// Reload table
	[self.table reloadData];
	
}

@end

////////////////////////////////////////////////////////////////////////////////
// MAYBE ///////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

//// Scrape data that is displayed in table right now
//- (void)scrapeData {
//	
//	// Find position of each column (so columns can be rearranged by clicking and dragging, and everything will still function)
//	NSInteger name_col_pos = -1;
//	NSInteger start_time_col_pos = -1;
//	NSInteger end_time_col_pos = -1;
//	NSInteger specific_stations_col_pos = -1;
//	NSInteger lunch_col_pos = -1;
//	for (int i = 0; i < self.table.numberOfColumns; i++) {
//		NSString *identifier = self.table.tableColumns[i].identifier;
//		if ([identifier isEqualToString:@"name_col"]) {
//			name_col_pos = i;
//		}
//		else if ([identifier isEqualToString:@"start_time_col"]) {
//			start_time_col_pos = i;
//		}
//		else if ([identifier isEqualToString:@"end_time_col"]) {
//			end_time_col_pos = i;
//		}
//		else if ([identifier isEqualToString:@"specific_stations_col"]) {
//			specific_stations_col_pos = i;
//		}
//		else if ([identifier isEqualToString:@"lunch_col"]) {
//			lunch_col_pos = i;
//		}
//	}
//	
//	// Update array of names
//	for (int i = 0; i < self.model.nameData.count; i++) {
//		NameTableCellView *cell = (NameTableCellView *) [self.table viewAtColumn:name_col_pos row:i makeIfNecessary:NO];
//		NSString *name = cell.name.stringValue;
//		if (name) { // do not insert nil object into array
//			self.model.nameData[i] = name;
//		}
//	}
//	
//	// Update array of start times
//	for (int i = 0; i < self.model.startTimeData.count; i++) {
//		StartTimeTableCellView *cell = (StartTimeTableCellView *) [self.table viewAtColumn:start_time_col_pos row:i makeIfNecessary:NO];
//		NSString *starttime = cell.starttime.selectedItem.title;
//		if (starttime) { // do not insert nil object into array
//			self.model.startTimeData[i] = starttime;
//		}
//	}
//	
//	// Update array of end times
//	for (int i = 0; i < self.model.endTimeData.count; i++) {
//		EndTimeTableCellView *cell = (EndTimeTableCellView *) [self.table viewAtColumn:end_time_col_pos row:i makeIfNecessary:NO];
//		NSString *endtime = cell.endtime.selectedItem.title;
//		if (endtime) { // do not insert nil object into array
//			self.model.endTimeData[i] = endtime;
//		}
//	}
//	
//	// Update array of specific stations
//	for (int i = 0; i < self.model.specificStationsData.count; i++) {
//		SpecificStationsTableCellView *cell = (SpecificStationsTableCellView *) [self.table viewAtColumn:specific_stations_col_pos row:i makeIfNecessary:NO];
//		// Specific station names
//		NSString *specific1 = cell.specific1.stringValue;
//		if (specific1) { // do not insert nil object into array
//			self.model.specificStationsData[i][0] = specific1;
//		}
//		NSString *specific2 = cell.specific2.stringValue;
//		if (specific2) { // do not insert nil object into array
//			self.model.specificStationsData[i][3] = specific2;
//		}
//		NSString *specific3 = cell.specific3.stringValue;
//		if (specific3) { // do not insert nil object into array
//			self.model.specificStationsData[i][6] = specific3;
//		}
//		// Specific station start times
//		NSString *specific1_starttime = cell.specific1_starttime.selectedItem.title;
//		if (specific1_starttime) { // do not insert nil object into array
//			self.model.specificStationsData[i][1] = specific1_starttime;
//		}
//		NSString *specific2_starttime = cell.specific2_starttime.selectedItem.title;
//		if (specific2_starttime) { // do not insert nil object into array
//			self.model.specificStationsData[i][4] = specific2_starttime;
//		}
//		NSString *specific3_starttime = cell.specific3_starttime.selectedItem.title;
//		if (specific3_starttime) { // do not insert nil object into array
//			self.model.specificStationsData[i][7] = specific3_starttime;
//		}
//		// Specific station end times
//		NSString *specific1_endtime = cell.specific1_endtime.selectedItem.title;
//		if (specific1_endtime) { // do not insert nil object into array
//			self.model.specificStationsData[i][2] = specific1_endtime;
//		}
//		NSString *specific2_endtime = cell.specific2_endtime.selectedItem.title;
//		if (specific2_endtime) { // do not insert nil object into array
//			self.model.specificStationsData[i][5] = specific2_endtime;
//		}
//		NSString *specific3_endtime = cell.specific3_endtime.selectedItem.title;
//		if (specific3_endtime) { // do not insert nil object into array
//			self.model.specificStationsData[i][8] = specific3_endtime;
//		}
//	}
//	
//	// Update array of lunch data
//	for (int i = 0; i < self.model.lunchData.count; i++) {
//		LunchTableCellView *cell = (LunchTableCellView *) [self.table viewAtColumn:lunch_col_pos row:i makeIfNecessary:NO];
//		int early_lunch_state = (int) cell.early_lunch.state;
//		int late_lunch_state = (int) cell.late_lunch.state;
//		int hour_lunch_state = (int) cell.hour_lunch.state;
//		int descriptive_int = early_lunch_state + (late_lunch_state * 2) + (hour_lunch_state * 4);
//		if (descriptive_int) { // do not insert nil object into array
//			self.model.lunchData[i] = [NSNumber numberWithInt:descriptive_int];
//		}
//	}
//	
//}
//
//// Called when the view controller’s view is about to be removed (i.e. when switching to another tab)
//- (void)viewWillDisappear {
//	
//	[self scrapeData];
//	
//}