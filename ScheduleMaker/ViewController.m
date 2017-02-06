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
#import "HourLunchTableCellView.h"

@implementation ViewController

// Do any additional setup after loading the view
- (void)viewDidLoad {
	
	// Super
	[super viewDidLoad];
	
	// Initialize arrays and keep track of numRows
	nameData = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", nil];
	startTimeData = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", nil];
	endTimeData = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", nil];
	hourLunchData = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
	
	// Checkbox states
	tenAM.state = NSOffState;
	elevenAM.state = NSOffState;
	twelvePM.state = NSOffState;
	onePM.state = NSOnState;
	twoPM.state = NSOnState;
	threePM.state = NSOnState;
	fourPM.state = NSOnState;
	
	// Checkbox states
	galleryCheckbox.state = NSOnState;
	securityCheckbox.state = NSOffState;
	station1Checkbox.state = NSOffState;
	station2Checkbox.state = NSOffState;
	
}

// Update the view, if already loaded
- (void)setRepresentedObject:(id)representedObject {
	
	[super setRepresentedObject:representedObject];

}

// Returns the number of records managed for a TableView by the data source object
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
	
	return nameData.count;

}

// Eliminate blue highlighting upon row selection in table
-(void)tableViewSelectionDidChange:(NSNotification *)aNotification {
	
	[table setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleNone];

}

// Scrape data that is displayed in table right now
- (void)scrapeData {
	
	// Update array of names
	for (int i = 0; i < nameData.count; i++) {
		NSString *name = ((NameTableCellView *) [table viewAtColumn:0 row:i makeIfNecessary:NO]).name.stringValue;
		if (name) { // do not insert nil object into array
			nameData[i] = name;
		}
	}
	
	// Update array of start times
	for (int i = 0; i < startTimeData.count; i++) {
		NSString *starttime = ((StartTimeTableCellView *) [table viewAtColumn:1 row:i makeIfNecessary:NO]).starttime.selectedItem.title;
		if (starttime) { // do not insert nil object into array
			startTimeData[i] = starttime;
		}
	}
	
	// Update array of end times
	for (int i = 0; i < endTimeData.count; i++) {
		NSString *endtime = ((EndTimeTableCellView *) [table viewAtColumn:2 row:i makeIfNecessary:NO]).endtime.selectedItem.title;
		if (endtime) { // do not insert nil object into array
			endTimeData[i] = endtime;
		}
	}
	
	// Update array of hour lunches: 1 if checked, 0 if not
	for (int i = 0; i < hourLunchData.count; i++) {
		int hourlunch = (int) ((HourLunchTableCellView *) [table viewAtColumn:3 row:i makeIfNecessary:NO]).hourlunch.state;
		if (hourlunch) { // do not insert nil object into array
			hourLunchData[i] = [NSNumber numberWithInt:hourlunch];
		}
	}

}

// Provides the table with the view to display in the cell at a specific column and row; also populates that cell with the appropriate data
// Different from -(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	
	if ([tableColumn.identifier isEqualToString:@"name_col"]) {
		NameTableCellView *cell = (NameTableCellView *) [tableView makeViewWithIdentifier:@"name_cell" owner:self];
		[cell.name setStringValue:[NSString stringWithFormat:@"%@", nameData[row]]];
		[cell.name setPlaceholderString:@"Name"];
		return cell;
	}

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
	
	else { //if ([tableColumn.identifier isEqualToString:@"hour_lunch_col"]) {
		HourLunchTableCellView *cell = (HourLunchTableCellView *) [tableView makeViewWithIdentifier:@"hour_lunch_cell" owner:self];
		if (row < hourLunchData.count) {
			[cell.hourlunch setState:[hourLunchData[row] integerValue]];
		}
		return cell;
	}
	
}

// When "+" add row button is pressed
- (IBAction)addRow:(id)sender {

	[self scrapeData];

	[nameData addObject:@""];
	[startTimeData addObject:@""];
	[endTimeData addObject:@""];
	[hourLunchData addObject:[NSNumber numberWithInt:0]];
	
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
	[hourLunchData removeLastObject];
	
	[table reloadData];
	
}

// When "Make Schedule" button is pressed (gather information, compute schedule)
- (IBAction)makeSchedule:(id)sender {
	
	// Number of rows and columns
	//NSInteger numRows = nameData.count;
	//NSInteger numCols = table.tableColumns.count;
	
	[self scrapeData];
	// Everything from scrape Data
	//
	// Checkbox states:
	//	tenAM.state
	//	elevenAM.state
	//	twelvePM.state = NSOffState;
	//	onePM.state = NSOnState;
	//	twoPM.state = NSOnState;
	//	threePM.state = NSOnState;
	//	fourPM.state = NSOnState;
	//	galleryCheckbox.state = NSOnState;
	//	securityCheckbox.state = NSOffState;
	//	station1Checkbox.state = NSOffState;
	//	station2Checkbox.state = NSOffState;
	
}

@end
