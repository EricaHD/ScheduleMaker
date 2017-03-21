//
//  ScheduleViewController.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 12/26/16.
//  Copyright © 2016 Erica Dominic. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Model.h"

// Constants
#define ROW_HEIGHT 75.0;

@interface ScheduleViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource> {
	
	// Table
	NSMutableArray *nameData;
	NSMutableArray *startTimeData;
	NSMutableArray *endTimeData;
	NSMutableArray *specificStationsData;
	NSMutableArray *lunchData;

}

// Table view on schedule view controller
@property (strong) IBOutlet NSTableView *table;

// Reference to model that all view controllers will use
@property (strong) Model *model;

// Add or delete table rows
- (IBAction)addRow:(id)sender;
- (IBAction)deleteRow:(id)sender;

// Make schedule!
- (IBAction)makeSchedule:(id)sender;

@end