//
//  RequirementsViewController.m
//  ScheduleMaker
//
//  Created by Erica Dominic on 3/11/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import "RequirementsViewController.h"
#import "StationTableCellView.h"
#import "StationStartTableCellView.h"
#import "StationEndTableCellView.h"
#import "StationFrequencyTableCellView.h"

@interface RequirementsViewController ()

@end

@implementation RequirementsViewController

// Do any additional setup after loading the view
- (void)viewDidLoad {
	
	// Super
    [super viewDidLoad];
	
	// Set row dimension, column dimensions, and column titles
	table.rowHeight = ROW_HEIGHT_2;
	table.tableColumns[0].title = @"Station";
	table.tableColumns[0].width = 100.0;
	table.tableColumns[1].title = @"Start Time";
	table.tableColumns[1].width = 100.0;
	table.tableColumns[2].title = @"End Time";
	table.tableColumns[2].width = 100.0;
	table.tableColumns[3].title = @"Shift Changes";
	table.tableColumns[3].width = 200.0;
	
	// Initialize arrays and keep track of numRows
	stationList = [NSMutableArray arrayWithObjects:@"Trike", @"-1", @"Coro", @"Gallery", @"-1", @"0", @"Greeting", @"Lesson", @"Project", @"Security", @"Tours", @"Manager", @"Birthday", @"Other", nil];
	stationData = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
	startTimeData = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil];
	endTimeData = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil];
	frequencyData = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil];

	// Half hour checkbox states
	tenAM.state = NSOffState; // DEFAULT
	elevenAM.state = NSOffState; // DEFAULT
	twelvePM.state = NSOffState; // DEFAULT
	onePM.state = NSOnState; // DEFAULT
	twoPM.state = NSOnState; // DEFAULT
	threePM.state = NSOnState; // DEFAULT
	fourPM.state = NSOnState; // DEFAULT
	
}

// Do any additional setup once the view is fully transitioned onto the screen
- (void)viewDidAppear {
	
	// Super
	[super viewDidAppear];
	
	// Set window title
	self.view.window.title = @"MoMath Floor Schedule Generator";
	
}

// Returns the number of records managed for a TableView by the data source object
// Note: this may be called before ViewDidLoad, so can't use stationList.count yet
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
	
	// Hard coded number of rows we should always have
	return 14;
	
}

// Provides the table with the view to display in the cell at a specific column and row; also populates that cell with the appropriate data
// Different from -(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	
	// Define cells in first column (station names)
	if ([tableColumn.identifier isEqualToString:@"station_col"]) {
		StationTableCellView *cell = (StationTableCellView *) [tableView makeViewWithIdentifier:@"station_cell" owner:self];
		[cell.station setTitle:stationList[row]];
		[cell.station setState:0]; // DEFAULT
		return cell;
	}
	
	// Define cells in second column (start times)
	else if ([tableColumn.identifier isEqualToString:@"station_start_col"]) {
		StationStartTableCellView *cell = (StationStartTableCellView *) [tableView makeViewWithIdentifier:@"station_start_cell" owner:self];
		[cell.starttime selectItemAtIndex:0]; // DEFAULT
		return cell;
	}
	
	// Define cells in third column (end times)
	else if ([tableColumn.identifier isEqualToString:@"station_end_col"]) {
		StationEndTableCellView *cell = (StationEndTableCellView *) [tableView makeViewWithIdentifier:@"station_end_cell" owner:self];
		[cell.endtime selectItemAtIndex:cell.endtime.menu.numberOfItems - 1]; // DEFAULT
		return cell;
	}
	
	else { // if ([tableColumn.identifier isEqualToString:@"frequency_col"]) {
		StationFrequencyTableCellView *cell = (StationFrequencyTableCellView *)[tableView makeViewWithIdentifier:@"frequency_cell" owner:self];
		[cell.frequency selectItemAtIndex:0]; // DEFAULT
		return cell;
	}
	
}

@end