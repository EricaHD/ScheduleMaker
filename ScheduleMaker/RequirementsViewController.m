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

// Be able to drag rows
#define MyPrivateTableViewDataType @"MyPrivateTableViewDataType"

@interface RequirementsViewController ()

// Half hours
@property (strong) IBOutlet NSButton *tenAM;
@property (strong) IBOutlet NSButton *elevenAM;
@property (strong) IBOutlet NSButton *twelvePM;
@property (strong) IBOutlet NSButton *onePM;
@property (strong) IBOutlet NSButton *twoPM;
@property (strong) IBOutlet NSButton *threePM;
@property (strong) IBOutlet NSButton *fourPM;

// Stack lunches
@property (strong) IBOutlet NSButton *firstLunch;
@property (strong) IBOutlet NSButton *secondLunch;
@property (strong) IBOutlet NSButton *thirdLunch;
@property (strong) IBOutlet NSButton *fourthLunch;
@property (strong) IBOutlet NSButton *fifthLunch;
@property (strong) IBOutlet NSButton *sixthLunch;

@end

@implementation RequirementsViewController

// Do any additional setup after loading the view
- (void)viewDidLoad {
	
	// Super
    [super viewDidLoad];
	
	// Set row dimension, column dimensions, and column titles
	self.table.rowHeight = ROW_HEIGHT_2;
	NSArray *columns = self.table.tableColumns;
	for (int i = 0; i < columns.count; i++) {
		NSTableColumn *col = columns[i];
		if ([col.identifier isEqualToString:@"reorder_col"]) {
			col.width = 30.0;
		}
		else if ([col.identifier isEqualToString:@"station_col"]) {
			col.title = @"Station";
			col.width = 100.0;
		}
		else if ([col.identifier isEqualToString:@"station_start_col"]) {
			col.title = @"Start Time";
			col.width = 100.0;
		}
		else if ([col.identifier isEqualToString:@"station_end_col"]) {
			col.title = @"End Time";
			col.width = 100.0;
		}
		else if ([col.identifier isEqualToString:@"frequency_col"]) {
			col.title = @"Shift Changes";
			col.width = 165.0;
		}
	}
	
	// Make it impossible to select/highlight a row in the table
	[self.table setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleNone];
	
	// Be able to drag rows
	[self.table registerForDraggedTypes:[NSArray arrayWithObject:MyPrivateTableViewDataType]];
	
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

	return self.model.stationList.count;
	
}

// Provides the table with the view to display in the cell at a specific column and row; also populates that cell with the appropriate data
// Different from -(id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	
	// Define cells in reorder icon column (icon specified in Storyboard)
	if ([tableColumn.identifier isEqualToString:@"reorder_col"]) {
		NSTableCellView *cell = (NSTableCellView *) [tableView makeViewWithIdentifier:@"reorder_cell" owner:self];
		return cell;
	}
	
	// Define cells in station names column
	else if ([tableColumn.identifier isEqualToString:@"station_col"]) {
		StationTableCellView *cell = (StationTableCellView *) [tableView makeViewWithIdentifier:@"station_cell" owner:self];
		[cell.station setTitle:self.model.stationList[row]];
		[cell.station setState:0]; // DEFAULT
		return cell;
	}
	
	// Define cells in start times column
	else if ([tableColumn.identifier isEqualToString:@"station_start_col"]) {
		StationStartTableCellView *cell = (StationStartTableCellView *) [tableView makeViewWithIdentifier:@"station_start_cell" owner:self];
		[cell.starttime selectItemAtIndex:0]; // DEFAULT
		return cell;
	}
	
	// Define cells in end times column
	else if ([tableColumn.identifier isEqualToString:@"station_end_col"]) {
		StationEndTableCellView *cell = (StationEndTableCellView *) [tableView makeViewWithIdentifier:@"station_end_cell" owner:self];
		[cell.endtime selectItemAtIndex:cell.endtime.menu.numberOfItems - 1]; // DEFAULT
		return cell;
	}
	
	// Define cells in frequency column
	else if ([tableColumn.identifier isEqualToString:@"frequency_col"]) {
		StationFrequencyTableCellView *cell = (StationFrequencyTableCellView *)[tableView makeViewWithIdentifier:@"frequency_cell" owner:self];
		[cell.frequency selectItemAtIndex:0]; // DEFAULT
		return cell;
	}
	
	// Nothing
	else {
		return nil;
	}
	
}

// Drag and drop code: returns a Boolean value that indicates whether a drag operation is allowed
- (BOOL)tableView:(NSTableView *)tableView writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard *)pboard {
	
	// Copy the row numbers to the pasteboard
	NSData *zNSIndexSetData = [NSKeyedArchiver archivedDataWithRootObject:rowIndexes];
	[pboard declareTypes:[NSArray arrayWithObject:MyPrivateTableViewDataType] owner:self];
	[pboard setData:zNSIndexSetData forType:MyPrivateTableViewDataType];
	return YES;
	
}

// Drag and drop code: used by the table view to determine a valid drop target
- (NSDragOperation)tableView:(NSTableView *)tableView validateDrop:(id<NSDraggingInfo>)info proposedRow:(NSInteger)row proposedDropOperation:(NSTableViewDropOperation)dropOperation {
	
	// The dragging operation the data source will perform; can be NSDragOperationEvery
	return NSDragOperationMove;
	
}

// Drag and drop code: called by the table view when the mouse button is released over the table view that previously decided to allow a drop
- (BOOL)tableView:(NSTableView *)tableView acceptDrop:(id<NSDraggingInfo>)info row:(NSInteger)row dropOperation:(NSTableViewDropOperation)dropOperation {
	
	// Find index of row being dragged
	NSPasteboard* pboard = [info draggingPasteboard];
	NSData* rowData = [pboard dataForType:MyPrivateTableViewDataType];
	NSIndexSet* rowIndexes = [NSKeyedUnarchiver unarchiveObjectWithData:rowData];
	NSInteger dragRow = [rowIndexes firstIndex];

	// If row being dragged < destination row (dragging down)
	if (dragRow < row) {
//		[model insertObject:[model objectAtIndex:dragRow] atIndex:row]; // TODO
//		[model removeObjectAtIndex:dragRow]; // TODO
		[tableView noteNumberOfRowsChanged];
		[tableView moveRowAtIndex:dragRow toIndex:row - 1];
	}
	
	// If row being dragged >= destination row (dragging up)
	else {
//		ModelObj *obj = [model objectAtIndex:dragRow]; // TODO
//		[model removeObjectAtIndex:dragRow]; // TODO
//		[model insertObject:obj atIndex:row]; // TODO
		[tableView noteNumberOfRowsChanged];
		[tableView moveRowAtIndex:dragRow toIndex:row];
	}
		
	return YES;

}

// Update the half hour checkboxes on the right side of the view controller to reflect array entries
- (void)reloadHalfHourData {
	
	if (self.model.halfHourData.count == 7) {
		self.tenAM.state = ([self.model.halfHourData[0] intValue]) ? NSOnState : NSOffState;
		self.elevenAM.state = ([self.model.halfHourData[1] intValue]) ? NSOnState : NSOffState;
		self.twelvePM.state = ([self.model.halfHourData[2] intValue]) ? NSOnState : NSOffState;
		self.onePM.state = ([self.model.halfHourData[3] intValue]) ? NSOnState : NSOffState;
		self.twoPM.state = ([self.model.halfHourData[4] intValue]) ? NSOnState : NSOffState;
		self.threePM.state = ([self.model.halfHourData[5] intValue]) ? NSOnState : NSOffState;
		self.fourPM.state = ([self.model.halfHourData[6] intValue]) ? NSOnState : NSOffState;
	}
	else {
		NSLog(@"Error: self.model.halfHourData.count != 7");
	}
	
}

// Update the stack lunches checkboxes on the right side of the view controller to reflect array entries
- (void)reloadStackLunchesData {
	
	if (self.model.stackLunchesData.count == 6) {
		self.firstLunch.state = ([self.model.stackLunchesData[0] intValue]) ? NSOnState : NSOffState;
		self.secondLunch.state = ([self.model.stackLunchesData[1] intValue]) ? NSOnState : NSOffState;
		self.thirdLunch.state = ([self.model.stackLunchesData[2] intValue]) ? NSOnState : NSOffState;
		self.fourthLunch.state = ([self.model.stackLunchesData[3] intValue]) ? NSOnState : NSOffState;
		self.fifthLunch.state = ([self.model.stackLunchesData[4] intValue]) ? NSOnState : NSOffState;
		self.sixthLunch.state = ([self.model.stackLunchesData[5] intValue]) ? NSOnState : NSOffState;
	}
	else {
		NSLog(@"Error: self.model.stackLunchesData.count != 6");
	}
	
}

@end