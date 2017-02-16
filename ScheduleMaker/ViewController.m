//
//  ViewController.m
//  ScheduleMaker
//
//  Created by Erica Dominic on 12/26/16.
//  Copyright © 2016 Erica Dominic. All rights reserved.
//

#import "ViewController.h"
#import "NameTableCellView.h"
#import "StartTimeTableCellView.h"
#import "EndTimeTableCellView.h"
#import "SpecificStationsTableCellView.h"
#import "MayBePlacedTableCellView.h"
#import "LunchTableCellView.h"
#import "Model.h"

@implementation ViewController

// Do any additional setup after loading the view
- (void)viewDidLoad {
	
	// Super
	[super viewDidLoad];
	
	// Set row dimension, column dimensions, and column titles
	table.rowHeight = ROW_HEIGHT;
	table.tableColumns[0].title = @"Name";
	table.tableColumns[0].width = 100.0;
	table.tableColumns[1].title = @"Start Time";
	table.tableColumns[1].width = 100.0;
	table.tableColumns[2].title = @"End Time";
	table.tableColumns[2].width = 100.0;
	table.tableColumns[3].title = @"Specific Stations";
	table.tableColumns[3].width = 307.0;
	table.tableColumns[4].title = @"May Be Placed";
	table.tableColumns[4].width = 250.0;
	table.tableColumns[5].title = @"Lunch";
	table.tableColumns[5].width = 100.0;
	
	// Make it impossible to select/highlight a row in the table
	[table setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleNone];
	
	// Initialize arrays and keep track of numRows
	nameData = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", nil];
	startTimeData = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", nil];
	endTimeData = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", nil];
	specificStationsData = [NSMutableArray arrayWithObjects:
							[NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", nil],
							[NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", nil],
							[NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", nil],
							[NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", nil],
							[NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", nil], nil];
	mayBePlacedData = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
	lunchData = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
	
	// Stations checkbox states
	birthday.state = NSOffState;
	gallery.state = NSOnState;
	greeting.state = NSOffState;
	lesson.state = NSOffState;
	manager.state = NSOffState;
	other.state = NSOffState;
	project.state = NSOffState;
	security.state = NSOffState;
	tours.state = NSOffState;
	
	// Station start times checkbox states
	[birthday_starttime selectItemAtIndex:0];
	[gallery_starttime selectItemAtIndex:0];
	[greeting_starttime selectItemAtIndex:0];
	[lesson_starttime selectItemAtIndex:0];
	[manager_starttime selectItemAtIndex:0];
	[other_starttime selectItemAtIndex:0];
	[project_starttime selectItemAtIndex:0];
	[security_starttime selectItemAtIndex:0];
	[tours_starttime selectItemAtIndex:0];

	// Station end times checkbox states
	[birthday_endtime selectItemAtIndex:birthday_endtime.menu.numberOfItems - 1];
	[gallery_endtime selectItemAtIndex:birthday_endtime.menu.numberOfItems - 1];
	[greeting_endtime selectItemAtIndex:birthday_endtime.menu.numberOfItems - 1];
	[lesson_endtime selectItemAtIndex:birthday_endtime.menu.numberOfItems - 1];
	[manager_endtime selectItemAtIndex:birthday_endtime.menu.numberOfItems - 1];
	[other_endtime selectItemAtIndex:birthday_endtime.menu.numberOfItems - 1];
	[project_endtime selectItemAtIndex:birthday_endtime.menu.numberOfItems - 1];
	[security_endtime selectItemAtIndex:birthday_endtime.menu.numberOfItems - 1];
	[tours_endtime selectItemAtIndex:birthday_endtime.menu.numberOfItems - 1];
	
	// Station changes checkbox states
	[birthday_changes selectItemAtIndex:0];
	[gallery_changes selectItemAtIndex:0];
	[greeting_changes selectItemAtIndex:0];
	[lesson_changes selectItemAtIndex:0];
	[manager_changes selectItemAtIndex:0];
	[other_changes selectItemAtIndex:0];
	[project_changes selectItemAtIndex:0];
	[security_changes selectItemAtIndex:0];
	[tours_changes selectItemAtIndex:0];
	
	// Half hour checkbox states
	tenAM.state = NSOffState;
	elevenAM.state = NSOffState;
	twelvePM.state = NSOffState;
	onePM.state = NSOnState;
	twoPM.state = NSOnState;
	threePM.state = NSOnState;
	fourPM.state = NSOnState;
	
	// Set background color for table headers (gray matching gray in alternating rows)
	NSView *box = [[NSView alloc] initWithFrame:CGRectMake(0.0, 0.0, 1000.0, 30.0)];
	[box setWantsLayer:YES];
	NSColor *color = [NSColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:0.25f];
	[box.layer setBackgroundColor:color.CGColor];
	[table.headerView addSubview:box];
	
	// Set background color for table rows (alternating blue/purple and gray for 20 lines)
	for (int i = 0; i < 20; i++) {
		NSView *box = [[NSView alloc] initWithFrame:CGRectMake(0.0, 77.0*i, 1000.0, 77.0)];
		[box setWantsLayer:YES];
		NSColor *color;
		if ((i % 2) == 0) {
			color = [NSColor colorWithRed:3.0/255.0 green:81.0/255.0 blue:223.0/255.0 alpha:0.25f];
		}
		if ((i % 2) == 1) {
			color = [NSColor colorWithRed:190.0/255.0 green:190.0/255.0 blue:190.0/255.0 alpha:0.25f];
		}
		[box.layer setBackgroundColor:color.CGColor];
		[table addSubview:box];
	}
	
	// Set background color for bottom part of window--unnecessary
//	self.view.wantsLayer = YES;
//	if (self.view.layer != nil) {
//		self.view.layer.backgroundColor = [NSColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:0.25f].CGColor;
//	}
	
}

// Do any additional setup once the view is fully transitioned onto the screen
- (void)viewDidAppear {
	
	// Super
	[super viewDidAppear];
	
	// Set window title
	self.view.window.title = @"MoMath Floor Schedule Generator";
	
}

// Update the view, if already loaded
- (void)setRepresentedObject:(id)representedObject {
	
	[super setRepresentedObject:representedObject];

}

// Returns the number of records managed for a TableView by the data source object
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
	
	return nameData.count;

}

// Scrape data that is displayed in table right now
- (void)scrapeData {
	
	// Find position of each column (so columns can be rearranged by clicking and dragging, and everything will still function)
	NSInteger name_col_pos = -1;
	NSInteger start_time_col_pos = -1;
	NSInteger end_time_col_pos = -1;
	NSInteger specific_stations_col_pos = -1;
	NSInteger may_be_placed_col_pos = -1;
	NSInteger lunch_col_pos = -1;
	for (int i = 0; i < table.numberOfColumns; i++) {
		NSString *identifier = table.tableColumns[i].identifier;
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
		else if ([identifier isEqualToString:@"may_be_placed_col"]) {
			may_be_placed_col_pos = i;
		}
		else { // if ([identifier isEqualToString:@"lunch_col"])
			lunch_col_pos = i;
		}
	}

	// Update array of names
	for (int i = 0; i < nameData.count; i++) {
		NameTableCellView *cell = (NameTableCellView *) [table viewAtColumn:name_col_pos row:i makeIfNecessary:NO];
		NSString *name = cell.name.stringValue;
		if (name) { // do not insert nil object into array
			nameData[i] = name;
		}
	}
	
	// Update array of start times
	for (int i = 0; i < startTimeData.count; i++) {
		StartTimeTableCellView *cell = (StartTimeTableCellView *) [table viewAtColumn:start_time_col_pos row:i makeIfNecessary:NO];
		NSString *starttime = cell.starttime.selectedItem.title;
		if (starttime) { // do not insert nil object into array
			startTimeData[i] = starttime;
		}
	}
	
	// Update array of end times
	for (int i = 0; i < endTimeData.count; i++) {
		EndTimeTableCellView *cell = (EndTimeTableCellView *) [table viewAtColumn:end_time_col_pos row:i makeIfNecessary:NO];
		NSString *endtime = cell.endtime.selectedItem.title;
		if (endtime) { // do not insert nil object into array
			endTimeData[i] = endtime;
		}
	}

	// Update array of specific stations
	for (int i = 0; i < specificStationsData.count; i++) {
		SpecificStationsTableCellView *cell = (SpecificStationsTableCellView *) [table viewAtColumn:specific_stations_col_pos row:i makeIfNecessary:NO];
		// Specific station names
		NSString *specific1 = cell.specific1.stringValue;
		if (specific1) { // do not insert nil object into array
			specificStationsData[i][0] = specific1;
		}
		NSString *specific2 = cell.specific2.stringValue;
		if (specific2) { // do not insert nil object into array
			specificStationsData[i][3] = specific2;
		}
		NSString *specific3 = cell.specific3.stringValue;
		if (specific3) { // do not insert nil object into array
			specificStationsData[i][6] = specific3;
		}
		// Specific station start times
		NSString *specific1_starttime = cell.specific1_starttime.selectedItem.title;
		if (specific1_starttime) { // do not insert nil object into array
			specificStationsData[i][1] = specific1_starttime;
		}
		NSString *specific2_starttime = cell.specific2_starttime.selectedItem.title;
		if (specific2_starttime) { // do not insert nil object into array
			specificStationsData[i][4] = specific2_starttime;
		}
		NSString *specific3_starttime = cell.specific3_starttime.selectedItem.title;
		if (specific3_starttime) { // do not insert nil object into array
			specificStationsData[i][7] = specific3_starttime;
		}
		// Specific station end times
		NSString *specific1_endtime = cell.specific1_endtime.selectedItem.title;
		if (specific1_endtime) { // do not insert nil object into array
			specificStationsData[i][2] = specific1_endtime;
		}
		NSString *specific2_endtime = cell.specific2_endtime.selectedItem.title;
		if (specific2_endtime) { // do not insert nil object into array
			specificStationsData[i][5] = specific2_endtime;
		}
		NSString *specific3_endtime = cell.specific3_endtime.selectedItem.title;
		if (specific3_endtime) { // do not insert nil object into array
			specificStationsData[i][8] = specific3_endtime;
		}
	}
	
	// Update array of may be placed qualifications
	// In MayBePlacedTableCellView.h, read about how the state of the entire cell (including 9 checkboxes) is represented as a single integer
	for (int i = 0; i < mayBePlacedData.count; i++) {
		MayBePlacedTableCellView *cell = (MayBePlacedTableCellView *) [table viewAtColumn:may_be_placed_col_pos row:i makeIfNecessary:NO];
		int birthday_state = (int) cell.birthday.state;
		int gallery_state = (int) cell.gallery.state;
		int greeting_state = (int) cell.greeting.state;
		int lesson_state = (int) cell.lesson.state;
		int manager_state = (int) cell.manager.state;
		int other_state = (int) cell.other.state;
		int project_state = (int) cell.project.state;
		int security_state = (int) cell.security.state;
		int tours_state = (int) cell.tours.state;
		int descriptive_int = birthday_state + (gallery_state * 2) + (greeting_state * 4) + (lesson_state * 8)
			+ (manager_state * 16) + (other_state * 32) + (project_state * 64) + (security_state * 128) + (tours_state * 256);
		if (descriptive_int) { // do not insert nil object into array
			mayBePlacedData[i] = [NSNumber numberWithInt:descriptive_int];
		}
	}
	
	// Update array of lunch data
	for (int i = 0; i < lunchData.count; i++) {
		LunchTableCellView *cell = (LunchTableCellView *) [table viewAtColumn:lunch_col_pos row:i makeIfNecessary:NO];
		int early_lunch_state = (int) cell.early_lunch.state;
		int late_lunch_state = (int) cell.late_lunch.state;
		int hour_lunch_state = (int) cell.hour_lunch.state;
		int descriptive_int = early_lunch_state + (late_lunch_state * 2) + (hour_lunch_state * 4);
		if (descriptive_int) { // do not insert nil object into array
			lunchData[i] = [NSNumber numberWithInt:descriptive_int];
		}
	}

}

// Provides the table with the view to display in the cell at a specific column and row; also populates that cell with the appropriate data
// Different from -(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	
	// Define cells in first column (names)
	if ([tableColumn.identifier isEqualToString:@"name_col"]) {
		NameTableCellView *cell = (NameTableCellView *) [tableView makeViewWithIdentifier:@"name_cell" owner:self];
		[cell.name setStringValue:[NSString stringWithFormat:@"%@", nameData[row]]];
		[cell.name setPlaceholderString:@"Name"];
		return cell;
	}

	// Define cells in second column (start times)
	else if ([tableColumn.identifier isEqualToString:@"start_time_col"]) {
		StartTimeTableCellView *cell = (StartTimeTableCellView *) [tableView makeViewWithIdentifier:@"start_time_cell" owner:self];
		if ([startTimeData[row] isEqualToString:@""]) {
			[cell.starttime selectItemAtIndex:0];
		}
		else {
			[cell.starttime selectItemWithTitle:startTimeData[row]];
		}
		return cell;
	}
	
	// Define cells in third column (end times)
	else if ([tableColumn.identifier isEqualToString:@"end_time_col"]) {
		EndTimeTableCellView *cell = (EndTimeTableCellView *) [tableView makeViewWithIdentifier:@"end_time_cell" owner:self];
		if ([endTimeData[row] isEqualToString:@""]) {
			[cell.endtime selectItemAtIndex:cell.endtime.menu.numberOfItems - 1];
		}
		else {
			[cell.endtime selectItemWithTitle:endTimeData[row]];
		}
		return cell;
	}
	
	// Define cells in fourth column (specific stations)
	else if ([tableColumn.identifier isEqualToString:@"specific_stations_col"]) {
		SpecificStationsTableCellView *cell = (SpecificStationsTableCellView *)[tableView makeViewWithIdentifier:@"specific_stations_cell" owner:self];
		// cell.specific1
		[cell.specific1 setStringValue:[NSString stringWithFormat:@"%@", specificStationsData[row][0]]];
		[cell.specific1 setPlaceholderString:@"Station"];
		// cell.specific1_starttime
		if ([specificStationsData[row][1] isEqualToString:@""]) {
			[cell.specific1_starttime selectItemAtIndex:0];
		}
		else {
			[cell.specific1_starttime selectItemWithTitle:specificStationsData[row][1]];
		}
		// cell.specific1_endtime
		if ([specificStationsData[row][2] isEqualToString:@""]) {
			[cell.specific1_endtime selectItemAtIndex:cell.specific1_endtime.menu.numberOfItems - 1];
		}
		else {
			[cell.specific1_endtime selectItemWithTitle:specificStationsData[row][2]];
		}
		// cell.specific2
		[cell.specific2 setStringValue:[NSString stringWithFormat:@"%@", specificStationsData[row][3]]];
		[cell.specific2 setPlaceholderString:@"Station"];
		// cell.specific2_starttime
		if ([specificStationsData[row][4] isEqualToString:@""]) {
			[cell.specific2_starttime selectItemAtIndex:0];
		}
		else {
			[cell.specific2_starttime selectItemWithTitle:specificStationsData[row][4]];
		}
		// cell.specific2_endtime
		if ([specificStationsData[row][5] isEqualToString:@""]) {
			[cell.specific2_endtime selectItemAtIndex:cell.specific1_endtime.menu.numberOfItems - 1];
		}
		else {
			[cell.specific2_endtime selectItemWithTitle:specificStationsData[row][5]];
		}
		// cell.specific3
		[cell.specific3 setStringValue:[NSString stringWithFormat:@"%@", specificStationsData[row][6]]];
		[cell.specific3 setPlaceholderString:@"Station"];
		// cell.specific3_starttime
		if ([specificStationsData[row][7] isEqualToString:@""]) {
			[cell.specific3_starttime selectItemAtIndex:0];
		}
		else {
			[cell.specific3_starttime selectItemWithTitle:specificStationsData[row][7]];
		}
		// cell.specific3_endtime
		if ([specificStationsData[row][8] isEqualToString:@""]) {
			[cell.specific3_endtime selectItemAtIndex:cell.specific1_endtime.menu.numberOfItems - 1];
		}
		else {
			[cell.specific3_endtime selectItemWithTitle:specificStationsData[row][8]];
		}
		return cell;
	}
	
	// Define cells in fifth column (may be placed)
	else if ([tableColumn.identifier isEqualToString:@"may_be_placed_col"]) {
		MayBePlacedTableCellView *cell = (MayBePlacedTableCellView *)[tableView makeViewWithIdentifier:@"may_be_placed_cell" owner:self];
		[cell.birthday setState:(1 & [mayBePlacedData[row] integerValue])];
		[cell.gallery setState:(2 & [mayBePlacedData[row] integerValue])];
		[cell.greeting setState:(4 & [mayBePlacedData[row] integerValue])];
		[cell.lesson setState:(8 & [mayBePlacedData[row] integerValue])];
		[cell.manager setState:(16 & [mayBePlacedData[row] integerValue])];
		[cell.other setState:(32 & [mayBePlacedData[row] integerValue])];
		[cell.project setState:(64 & [mayBePlacedData[row] integerValue])];
		[cell.security setState:(128 & [mayBePlacedData[row] integerValue])];
		[cell.tours setState:(256 & [mayBePlacedData[row] integerValue])];
		return cell;
	}
	
	// Define cells in sixth column (lunches)
	else { // if ([tableColumn.identifier isEqualToString:@"lunch_col"])
		LunchTableCellView *cell = (LunchTableCellView *)[tableView makeViewWithIdentifier:@"lunch_cell" owner:self];
		[cell.early_lunch setState:(1 & [lunchData[row] integerValue])];
		[cell.late_lunch setState:(2 & [lunchData[row] integerValue])];
		[cell.hour_lunch setState:(4 & [lunchData[row] integerValue])];
		return cell;
	}
	
}

// When "+" add row button is pressed
- (IBAction)addRow:(id)sender {

	[self scrapeData];

	[nameData addObject:@""];
	[startTimeData addObject:@""];
	[endTimeData addObject:@""];
	[specificStationsData addObject:[NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", nil]];
	[mayBePlacedData addObject:[NSNumber numberWithInt:0]];
	[lunchData addObject:[NSNumber numberWithInt:0]];
	
	[table reloadData];
	
}

// When "-" delete row button is pressed
- (IBAction)deleteRow:(id)sender {
	
	if (nameData.count == 0) {
		return;
	}
	
	[self scrapeData];
	
	[nameData removeLastObject];
	[startTimeData removeLastObject];
	[endTimeData removeLastObject];
	[specificStationsData removeLastObject];
	[mayBePlacedData removeLastObject];
	[lunchData removeLastObject];
	
	[table reloadData];
	
}

- (void)showAlert:(NSString *)title withDetails:(NSString *)details {
	NSAlert *alert = [[NSAlert alloc] init];
	[alert addButtonWithTitle:@"OK"];
	[alert setMessageText:title];
	[alert setInformativeText:details];
	[alert setAlertStyle:NSInformationalAlertStyle];
	[alert beginSheetModalForWindow:self.view.window completionHandler:nil];
}

// When "Make Schedule" button is pressed (gather information, compute schedule)
- (IBAction)makeSchedule:(id)sender {
	
	// Update arrays of information from table rows
	[self scrapeData];
	
	// Create model; set number of staff for input into following method calls
	model = [[Model alloc] init];
	[model setNumStaff:nameData];
	
	// Error checking: ensure start time < end time for each shift
	int valid;
	valid = [model checkShiftTimesFor:startTimeData until:endTimeData];
	if (valid != 0) {
		[self showAlert:@"Invalid start/end times" withDetails:[NSString stringWithFormat:@"Please check shift times in row #%d.", valid]];
	}
	
	// Error checking: ensure start time < end time for each specific station entry
	valid = [model checkSpecialStationTimesFor:specificStationsData];
	if (valid != 0) {
		[self showAlert:@"Invalid start/end times" withDetails:[NSString stringWithFormat:@"Please check specific station times in row #%d.", valid]];
	}

	// X out hours that are outside a staff member's shift
	[model blockOutNonShiftHours:startTimeData until:endTimeData];

	// Set up hours/half hours
	// Special assignments
	// Lunch times
	// Trike
	// Coro
	// Gallery, and other random stations entered on the bottom
	// -1
	// -1
	// 0
	// Float (the rest)
	// Display errors in dialogue box
	// Open Excel or LibreOffice and enter information
	// Add autocomplete functionality

	[model printSchedule:nameData];
	
////////////////////////////////////////////////////////////////////////////////
	
//	nameData; - used to count # rows actually containing info
//	startTimeData; - used in error checking 1
//	endTimeData; - used in error checking 1
//	specificStationsData; - used in error checking 2
//	mayBePlacedData;
//	lunchData;
//
//	birthday;
//	gallery;
//	greeting;
//	lesson;
//	manager;
//	other;
//	project;
//	security;
//	tours;
//	
//	birthday_starttime;
//	gallery_starttime;
//	greeting_starttime;
//	lesson_starttime;
//	manager_starttime;
//	other_starttime;
//	project_starttime;
//	security_starttime;
//	tours_starttime;
//	
//	birthday_endtime;
//	gallery_endtime;
//	greeting_endtime;
//	lesson_endtime;
//	manager_endtime;
//	other_endtime;
//	project_endtime;
//	security_endtime;
//	tours_endtime;
//	
//	birthday_changes;
//	gallery_changes;
//	greeting_changes;
//	lesson_changes;
//	manager_changes;
//	other_changes;
//	project_changes;
//	security_changes;
//	tours_changes;
//	
//	tenAM;
//	elevenAM;
//	twelvePM;
//	onePM;
//	twoPM;
//	threePM;
//	fourPM;
	
}

@end