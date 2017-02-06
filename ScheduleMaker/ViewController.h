//
//  ViewController.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 12/26/16.
//  Copyright © 2016 Erica Dominic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource> {
	
	// Table
	NSMutableArray *nameData;
	NSMutableArray *startTimeData;
	NSMutableArray *endTimeData;
	NSMutableArray *hourLunchData;
	IBOutlet NSTableView *table;

	// Half hours
	IBOutlet NSButton *tenAM;
	IBOutlet NSButton *elevenAM;
	IBOutlet NSButton *twelvePM;
	IBOutlet NSButton *onePM;
	IBOutlet NSButton *twoPM;
	IBOutlet NSButton *threePM;
	IBOutlet NSButton *fourPM;
	
	// Extra stations
	IBOutlet NSButton *galleryCheckbox;
	IBOutlet NSButton *securityCheckbox;
	IBOutlet NSButton *station1Checkbox;
	IBOutlet NSButton *station2Checkbox;

}

// Add or delete table rows
- (IBAction)addRow:(id)sender;
- (IBAction)deleteRow:(id)sender;

// Make schedule!
- (IBAction)makeSchedule:(id)sender;

@end
