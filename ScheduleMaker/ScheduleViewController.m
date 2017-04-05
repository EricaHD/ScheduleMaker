//
//  ScheduleViewController.m
//  ScheduleMaker
//
//  Created by Erica Dominic on 12/26/16.
//  Copyright © 2016 Erica Dominic. All rights reserved.
//

#import "ScheduleViewController.h"
#import "NameTableCellView.h"
#import "StartTimeTableCellView.h"
#import "EndTimeTableCellView.h"
#import "SpecificStationsTableCellView.h"
#import "LunchTableCellView.h"

@interface ScheduleViewController ()

// Add and delete table rows
- (IBAction)addRow:(id)sender;
- (IBAction)deleteRow:(id)sender;

// Make schedule!
- (IBAction)makeSchedule:(id)sender;

@end

@implementation ScheduleViewController

// Do any additional setup after loading the view
- (void)viewDidLoad {
	
	// Super
	[super viewDidLoad];
	
	// Set row dimension, column dimensions, and column titles
	self.table.rowHeight = ROW_HEIGHT;
	NSArray *columns = self.table.tableColumns;
	for (int i = 0; i < columns.count; i++) {
		NSTableColumn *col = columns[i];
		if ([col.identifier isEqualToString:@"name_col"]) {
			col.title = @"Name";
			col.width = 100.0;
		}
		else if ([col.identifier isEqualToString:@"start_time_col"]) {
			col.title = @"Start Time";
			col.width = 100.0;
		}
		else if ([col.identifier isEqualToString:@"end_time_col"]) {
			col.title = @"End Time";
			col.width = 100.0;
		}
		else if ([col.identifier isEqualToString:@"specific_stations_col"]) {
			col.title = @"Specific Stations";
			col.width = 307.0;
		}
		else if ([col.identifier isEqualToString:@"lunch_col"]) {
			col.title = @"Lunch";
			col.width = 100.0;
		}
	}
	
	// Make it impossible to select/highlight a row in the table
	[self.table setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleNone];
	
	// Reload table
	[self.table reloadData];
	
}

// Autocomplete code: when name text field editing ends (then hide table)
- (void)controlTextDidChange:(NSNotification *)notification {
	
	NSTextField *editedTextField = [notification object];
	NSLog(@"Name text field in row %ld has been edited; it now says %@", (long)editedTextField.tag, editedTextField.stringValue);
	
}

// Do any additional setup once the view is fully transitioned onto the screen
- (void)viewDidAppear {
	
	// Super
	[super viewDidAppear];
	
}

// Returns the number of records managed for a TableView by the data source object
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
	
	return self.model.nameData.count;

}

// Provides the table with the view to display in the cell at a specific column and row; also populates that cell with the appropriate data
// Different from -(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	
	// Define cells in first column (names)
	if ([tableColumn.identifier isEqualToString:@"name_col"]) {
		NameTableCellView *cell = (NameTableCellView *) [tableView makeViewWithIdentifier:@"name_cell" owner:self];
		[cell.name setStringValue:[NSString stringWithFormat:@"%@", self.model.nameData[row]]];
		[cell.name setPlaceholderString:@"Name"];
		// Autocomplete code: this way controlTextDidChange() method will work
		cell.name.delegate = self;
		cell.name.tag = row;
		return cell;
	}

	// Define cells in second column (start times)
	else if ([tableColumn.identifier isEqualToString:@"start_time_col"]) {
		StartTimeTableCellView *cell = (StartTimeTableCellView *) [tableView makeViewWithIdentifier:@"start_time_cell" owner:self];
		if ([self.model.startTimeData[row] isEqualToString:@""]) {
			[cell.starttime selectItemAtIndex:4];
		}
		else {
			[cell.starttime selectItemWithTitle:self.model.startTimeData[row]];
		}
		return cell;
	}
	
	// Define cells in third column (end times)
	else if ([tableColumn.identifier isEqualToString:@"end_time_col"]) {
		EndTimeTableCellView *cell = (EndTimeTableCellView *) [tableView makeViewWithIdentifier:@"end_time_cell" owner:self];
		if ([self.model.endTimeData[row] isEqualToString:@""]) {
			[cell.endtime selectItemAtIndex:cell.endtime.menu.numberOfItems - 1];
		}
		else {
			[cell.endtime selectItemWithTitle:self.model.endTimeData[row]];
		}
		return cell;
	}
	
	// Define cells in fourth column (specific stations)
	else if ([tableColumn.identifier isEqualToString:@"specific_stations_col"]) {
		SpecificStationsTableCellView *cell = (SpecificStationsTableCellView *)[tableView makeViewWithIdentifier:@"specific_stations_cell" owner:self];
		// cell.specific1
		[cell.specific1 setStringValue:[NSString stringWithFormat:@"%@", self.model.specificStationsData[row][0]]];
		[cell.specific1 setPlaceholderString:@"Station"];
		// cell.specific1_starttime
		if ([self.model.specificStationsData[row][1] isEqualToString:@""]) {
			[cell.specific1_starttime selectItemAtIndex:0];
		}
		else {
			[cell.specific1_starttime selectItemWithTitle:self.model.specificStationsData[row][1]];
		}
		// cell.specific1_endtime
		if ([self.model.specificStationsData[row][2] isEqualToString:@""]) {
			[cell.specific1_endtime selectItemAtIndex:cell.specific1_endtime.menu.numberOfItems - 1];
		}
		else {
			[cell.specific1_endtime selectItemWithTitle:self.model.specificStationsData[row][2]];
		}
		// cell.specific2
		[cell.specific2 setStringValue:[NSString stringWithFormat:@"%@", self.model.specificStationsData[row][3]]];
		[cell.specific2 setPlaceholderString:@"Station"];
		// cell.specific2_starttime
		if ([self.model.specificStationsData[row][4] isEqualToString:@""]) {
			[cell.specific2_starttime selectItemAtIndex:0];
		}
		else {
			[cell.specific2_starttime selectItemWithTitle:self.model.specificStationsData[row][4]];
		}
		// cell.specific2_endtime
		if ([self.model.specificStationsData[row][5] isEqualToString:@""]) {
			[cell.specific2_endtime selectItemAtIndex:cell.specific1_endtime.menu.numberOfItems - 1];
		}
		else {
			[cell.specific2_endtime selectItemWithTitle:self.model.specificStationsData[row][5]];
		}
		// cell.specific3
		[cell.specific3 setStringValue:[NSString stringWithFormat:@"%@", self.model.specificStationsData[row][6]]];
		[cell.specific3 setPlaceholderString:@"Station"];
		// cell.specific3_starttime
		if ([self.model.specificStationsData[row][7] isEqualToString:@""]) {
			[cell.specific3_starttime selectItemAtIndex:0];
		}
		else {
			[cell.specific3_starttime selectItemWithTitle:self.model.specificStationsData[row][7]];
		}
		// cell.specific3_endtime
		if ([self.model.specificStationsData[row][8] isEqualToString:@""]) {
			[cell.specific3_endtime selectItemAtIndex:cell.specific1_endtime.menu.numberOfItems - 1];
		}
		else {
			[cell.specific3_endtime selectItemWithTitle:self.model.specificStationsData[row][8]];
		}
		return cell;
	}
	
	// Define cells in sixth column (lunches)
	else if ([tableColumn.identifier isEqualToString:@"lunch_col"]) {
		LunchTableCellView *cell = (LunchTableCellView *)[tableView makeViewWithIdentifier:@"lunch_cell" owner:self];
		[cell.early_lunch setState:(1 & [self.model.lunchData[row] integerValue])];
		[cell.late_lunch setState:(2 & [self.model.lunchData[row] integerValue])];
		[cell.hour_lunch setState:(4 & [self.model.lunchData[row] integerValue])];
		return cell;
	}
	
	// Otherwise
	else {
		return nil;
	}
	
}

// Scrape data that is displayed in table right now
- (void)scrapeData {
	
	// Find position of each column (so columns can be rearranged by clicking and dragging, and everything will still function)
	NSInteger name_col_pos = -1;
	NSInteger start_time_col_pos = -1;
	NSInteger end_time_col_pos = -1;
	NSInteger specific_stations_col_pos = -1;
	NSInteger lunch_col_pos = -1;
	for (int i = 0; i < self.table.numberOfColumns; i++) {
		NSString *identifier = self.table.tableColumns[i].identifier;
		if ([identifier isEqualToString:@"name_col"]) {
			name_col_pos = i;
		}
		else if ([identifier isEqualToString:@"start_time_col"]) {
			start_time_col_pos = i;
		}
		else if ([identifier isEqualToString:@"end_time_col"]) {
			end_time_col_pos = i;
		}
		else if ([identifier isEqualToString:@"specific_stations_col"]) {
			specific_stations_col_pos = i;
		}
		else if ([identifier isEqualToString:@"lunch_col"]) {
			lunch_col_pos = i;
		}
	}
	
	// Update array of names
	for (int i = 0; i < self.model.nameData.count; i++) {
		NameTableCellView *cell = (NameTableCellView *) [self.table viewAtColumn:name_col_pos row:i makeIfNecessary:NO];
		NSString *name = cell.name.stringValue;
		if (name) { // do not insert nil object into array
			self.model.nameData[i] = name;
		}
	}
	
	// Update array of start times
	for (int i = 0; i < self.model.startTimeData.count; i++) {
		StartTimeTableCellView *cell = (StartTimeTableCellView *) [self.table viewAtColumn:start_time_col_pos row:i makeIfNecessary:NO];
		NSString *starttime = cell.starttime.selectedItem.title;
		if (starttime) { // do not insert nil object into array
			self.model.startTimeData[i] = starttime;
		}
	}
	
	// Update array of end times
	for (int i = 0; i < self.model.endTimeData.count; i++) {
		EndTimeTableCellView *cell = (EndTimeTableCellView *) [self.table viewAtColumn:end_time_col_pos row:i makeIfNecessary:NO];
		NSString *endtime = cell.endtime.selectedItem.title;
		if (endtime) { // do not insert nil object into array
			self.model.endTimeData[i] = endtime;
		}
	}
	
	// Update array of specific stations
	for (int i = 0; i < self.model.specificStationsData.count; i++) {
		SpecificStationsTableCellView *cell = (SpecificStationsTableCellView *) [self.table viewAtColumn:specific_stations_col_pos row:i makeIfNecessary:NO];
		// Specific station names
		NSString *specific1 = cell.specific1.stringValue;
		if (specific1) { // do not insert nil object into array
			self.model.specificStationsData[i][0] = specific1;
		}
		NSString *specific2 = cell.specific2.stringValue;
		if (specific2) { // do not insert nil object into array
			self.model.specificStationsData[i][3] = specific2;
		}
		NSString *specific3 = cell.specific3.stringValue;
		if (specific3) { // do not insert nil object into array
			self.model.specificStationsData[i][6] = specific3;
		}
		// Specific station start times
		NSString *specific1_starttime = cell.specific1_starttime.selectedItem.title;
		if (specific1_starttime) { // do not insert nil object into array
			self.model.specificStationsData[i][1] = specific1_starttime;
		}
		NSString *specific2_starttime = cell.specific2_starttime.selectedItem.title;
		if (specific2_starttime) { // do not insert nil object into array
			self.model.specificStationsData[i][4] = specific2_starttime;
		}
		NSString *specific3_starttime = cell.specific3_starttime.selectedItem.title;
		if (specific3_starttime) { // do not insert nil object into array
			self.model.specificStationsData[i][7] = specific3_starttime;
		}
		// Specific station end times
		NSString *specific1_endtime = cell.specific1_endtime.selectedItem.title;
		if (specific1_endtime) { // do not insert nil object into array
			self.model.specificStationsData[i][2] = specific1_endtime;
		}
		NSString *specific2_endtime = cell.specific2_endtime.selectedItem.title;
		if (specific2_endtime) { // do not insert nil object into array
			self.model.specificStationsData[i][5] = specific2_endtime;
		}
		NSString *specific3_endtime = cell.specific3_endtime.selectedItem.title;
		if (specific3_endtime) { // do not insert nil object into array
			self.model.specificStationsData[i][8] = specific3_endtime;
		}
	}
	
	// Update array of lunch data
	for (int i = 0; i < self.model.lunchData.count; i++) {
		LunchTableCellView *cell = (LunchTableCellView *) [self.table viewAtColumn:lunch_col_pos row:i makeIfNecessary:NO];
		int early_lunch_state = (int) cell.early_lunch.state;
		int late_lunch_state = (int) cell.late_lunch.state;
		int hour_lunch_state = (int) cell.hour_lunch.state;
		int descriptive_int = early_lunch_state + (late_lunch_state * 2) + (hour_lunch_state * 4);
		if (descriptive_int) { // do not insert nil object into array
			self.model.lunchData[i] = [NSNumber numberWithInt:descriptive_int];
		}
	}
	
}

// When "+" add row button is pressed
- (IBAction)addRow:(id)sender {

	[self scrapeData];
	[self.model addRow];
	[self.table reloadData];
	
}

// When "-" delete row button is pressed
- (IBAction)deleteRow:(id)sender {
	
	[self scrapeData];
	[self.model deleteRow];
	[self.table reloadData];
	
}

// When "Make Schedule" button is pressed (gather information, compute schedule)
- (IBAction)makeSchedule:(id)sender {
	
	// Update arrays of information from table rows
	[self scrapeData];
	
	// Debugging
	//[self.model printScheduleData];
	//[self.model printRequirementsData];
	
	// Make schedule
	[self.model makeSchedule];
	
	// Debugging
	//[self.model printSchedule];
	
}

@end