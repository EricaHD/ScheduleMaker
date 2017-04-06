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

#define ROW_HEIGHT 100.0;

@interface ScheduleViewController ()

// Autocomplete code: positions dictionary used to compare user typed strings for specific stations autocomplete funcionality
@property (strong) NSMutableArray *positionsDictionary;

// Add and delete table rows
- (IBAction)addRow:(id)sender;
- (IBAction)deleteRow:(id)sender;

// Make schedule!
- (IBAction)makeSchedule:(id)sender;

@end

@implementation ScheduleViewController

#pragma mark View Loading Methods ##############################################

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
	
	// Autocomplete code: make autocomplete options an empty array
	self.autocompleteOptions = [[NSMutableArray alloc] init];
	
	// Autocomplete code: make positions dictionary for specific stations autocomplete functionality
	self.positionsDictionary = [[NSMutableArray alloc] initWithObjects:@"Trike", @"Coro", @"Gallery", @"-1", @"0", @"Float", @"Project",@"Greeting", @"Security", @"Tours", @"Lesson", @"Manager", @"Birthday", @"Other", nil];
	
	// Make it impossible to select/highlight a row in the table
	[self.table setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleNone];
	
	// Reload table
	[self.table reloadData];
	
}

// Do any additional setup once the view is fully transitioned onto the screen
- (void)viewDidAppear {
	
	// Super
	[super viewDidAppear];
	
}

#pragma mark NSTableViewDelegate, NSTableViewDataSource Methods ################

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
		cell.name.delegate = self; // Autocomplete code: this way controlTextDidChange() method will work
		cell.name.tag = row; // Autocomplete code: this way controlTextDidChange() method will work
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
		cell.specific1.delegate = self; // Autocomplete code: this way controlTextDidChange() method will work
		cell.specific1.tag = (row * -3) - 1; // Autocomplete code: this way controlTextDidChange() method will work
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
		cell.specific2.delegate = self; // Autocomplete code: this way controlTextDidChange() method will work
		cell.specific2.tag = (row * -3) - 2; // Autocomplete code: this way controlTextDidChange() method will work
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
		cell.specific3.delegate = self; // Autocomplete code: this way controlTextDidChange() method will work
		cell.specific3.tag = (row * -3) - 3; // Autocomplete code: this way controlTextDidChange() method will work
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

#pragma mark Add Row, Delete Row, and Make Schedule Buttons ####################

// Scrape data that is displayed in table right now
- (void)scrapeData {
	
	// Find position of each column (so columns can be rearranged by clicking and dragging, and everything will still function) - TODO maybe delete this functionality
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

#pragma mark Autocomplete Methods ##############################################

// Autocomplete code: when name text field editing changes (then hide table)
- (void)controlTextDidChange:(NSNotification *)notification {
	
	// Substring user has typed so far (plus capitalized version, in case user doesn't capitalize)
	NSTextField *editedTextField = [notification object];
	NSString *substring = editedTextField.stringValue;
	NSString *capitalizedSubstring = [substring capitalizedString];
	
	// Put anything that starts with substring into autocompleteOptions (for table)
	[self.autocompleteOptions removeAllObjects];
	
	// CASE 1: autocomplete in names column
	if (editedTextField.tag >= 0) {
		
		// Use self.model.staffNames as staff "dictionary"
		// Check substring (and capitalized substring) against dictionary element
		for (int i = 0; i < self.model.staffNames.count; i++) {
			NSString *dictElt = self.model.staffNames[i];
			NSRange capitalizedSubstringRange = [dictElt rangeOfString:capitalizedSubstring];
			NSRange substringRange = [dictElt rangeOfString:substring];
			if (substringRange.location == 0) {
				[self.autocompleteOptions addObject:dictElt];
			}
			else if (capitalizedSubstringRange.location == 0) {
				[self.autocompleteOptions addObject:dictElt];
			}
		}
	
		// Get NameTableViewCell: column = 0, row = editedTextField.tag
		NameTableCellView *cell = (NameTableCellView *) [self.table viewAtColumn:0 row:editedTextField.tag makeIfNecessary:NO];
	
		// Cell's autocomplete table should display items from self.autocompleteOptions; populate table; unhide scroll view
		cell.autocompleteOptions = self.autocompleteOptions;
		[cell.autocompleteTable reloadData];
		[cell.autocompleteScroll setHidden:NO];
		if ([cell.autocompleteScroll hasVerticalScroller]) {
			cell.autocompleteScroll.verticalScroller.floatValue = 0.0;
		}
		[cell.autocompleteScroll.contentView scrollToPoint:NSMakePoint(0.0, 0.0)];
		[cell.autocompleteScroll scrollPoint:NSMakePoint(0.0, 0.0)];
	
	}
	
	// CASE 2: autocomplete in specific stations column
	else {
		
		// Use self.positionsDictionary as possible positions "dictionary
		// Check substring (and capitalized substring) against dictionary element
		for (int i = 0; i < self.positionsDictionary.count; i++) {
			NSString *dictElt = self.positionsDictionary[i];
			NSRange substringRange = [dictElt rangeOfString:substring];
			NSRange capitalizedSubstringRange = [dictElt rangeOfString:capitalizedSubstring];
			if (substringRange.location == 0) {
				[self.autocompleteOptions addObject:dictElt];
			}
			else if (capitalizedSubstringRange.location == 0) {
				[self.autocompleteOptions addObject:dictElt];
			}
		}
				
		// Get SpecificStationsTableViewCell: column = 3, row = (-1 * (editedTextField.tag + 1))/3
		// And get one of the three tables/scrolls in that cell
		NSInteger row = (-1 * (editedTextField.tag + 1))/3;
		SpecificStationsTableCellView *cell = (SpecificStationsTableCellView *) [self.table viewAtColumn:3 row:row makeIfNecessary:NO];
		NSScrollView *whichScrollInCell;
		NSTableView *whichTableInCell;
		if ((-1 * (editedTextField.tag + 1)) % 3 == 0) {
			whichScrollInCell = cell.autocompleteScroll1;
			whichTableInCell = cell.autocompleteTable1;
		}
		else if ((-1 * (editedTextField.tag + 1)) % 3 == 1) {
			whichScrollInCell = cell.autocompleteScroll2;
			whichTableInCell = cell.autocompleteTable2;
		}
		else {
			whichScrollInCell = cell.autocompleteScroll3;
			whichTableInCell = cell.autocompleteTable3;
		}
		
		// Autocomplete table should display items from self.autocompleteOptions; populate table; unhide scroll view
		cell.autocompleteOptions = self.autocompleteOptions;
		[whichTableInCell reloadData];
		[whichScrollInCell setHidden:NO];
		if ([whichScrollInCell hasVerticalScroller]) {
			whichScrollInCell.verticalScroller.floatValue = 0.0;
		}
		[whichScrollInCell.contentView scrollToPoint:NSMakePoint(0.0, 0.0)];
		[whichScrollInCell scrollPoint:NSMakePoint(0.0, 0.0)];
		
	}
	
}

// Autocomplete code: when text field editing ends, selected or not (then hide table)
- (void)controlTextDidEndEditing:(NSNotification *)notification {
	
	NSTextField *editedTextField = [notification object];
	
	// CASE 1: autocomplete in names column
	if (editedTextField.tag >= 0) {
		NameTableCellView *cell = (NameTableCellView *) [self.table viewAtColumn:0 row:editedTextField.tag makeIfNecessary:NO];
		[cell.autocompleteScroll setHidden:YES];
	}
	
	// CASE 2: autocomplete in specific stations column
	else {
		NSInteger row = (-1 * (editedTextField.tag + 1))/3;
		SpecificStationsTableCellView *cell = (SpecificStationsTableCellView *) [self.table viewAtColumn:3 row:row makeIfNecessary:NO];
		if (-1 * (editedTextField.tag + 1) % 3 == 0) {
			[cell.autocompleteScroll1 setHidden:YES];
		}
		else if (-1 * (editedTextField.tag + 1) % 3 == 1) {
			[cell.autocompleteScroll2 setHidden:YES];
		}
		else {
			[cell.autocompleteScroll3 setHidden:YES];
		}
	}
	
}

@end