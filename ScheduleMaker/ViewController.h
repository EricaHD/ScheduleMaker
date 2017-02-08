//
//  ViewController.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 12/26/16.
//  Copyright © 2016 Erica Dominic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// Constants
#define TABLE_ROW_HEIGHT 75.0;

@interface ViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource> {
	
	// Table
	NSMutableArray *nameData;
	NSMutableArray *startTimeData;
	NSMutableArray *endTimeData;
	NSMutableArray *hourLunchData;
	NSMutableArray *mayBePlacedData;
	IBOutlet NSTableView *table;

	// Stations
	IBOutlet NSButton *birthday;
	IBOutlet NSButton *gallery;
	IBOutlet NSButton *greeting;
	IBOutlet NSButton *lesson;
	IBOutlet NSButton *manager;
	IBOutlet NSButton *other;
	IBOutlet NSButton *project;
	IBOutlet NSButton *security;
	IBOutlet NSButton *tours;
	
	// Station start times
	IBOutlet NSPopUpButton *birthday_starttime;
	IBOutlet NSPopUpButton *gallery_starttime;
	IBOutlet NSPopUpButton *greeting_starttime;
	IBOutlet NSPopUpButton *lesson_starttime;
	IBOutlet NSPopUpButton *manager_starttime;
	IBOutlet NSPopUpButton *other_starttime;
	IBOutlet NSPopUpButton *project_starttime;
	IBOutlet NSPopUpButton *security_starttime;
	IBOutlet NSPopUpButton *tours_starttime;
	
	// Station end times
	IBOutlet NSPopUpButton *birthday_endtime;
	IBOutlet NSPopUpButton *gallery_endtime;
	IBOutlet NSPopUpButton *greeting_endtime;
	IBOutlet NSPopUpButton *lesson_endtime;
	IBOutlet NSPopUpButton *manager_endtime;
	IBOutlet NSPopUpButton *other_endtime;
	IBOutlet NSPopUpButton *project_endtime;
	IBOutlet NSPopUpButton *security_endtime;
	IBOutlet NSPopUpButton *tours_endtime;
	
	// Station changes
	IBOutlet NSPopUpButton *birthday_changes;
	IBOutlet NSPopUpButton *gallery_changes;
	IBOutlet NSPopUpButton *greeting_changes;
	IBOutlet NSPopUpButton *lesson_changes;
	IBOutlet NSPopUpButton *manager_changes;
	IBOutlet NSPopUpButton *other_changes;
	IBOutlet NSPopUpButton *project_changes;
	IBOutlet NSPopUpButton *security_changes;
	IBOutlet NSPopUpButton *tours_changes;
	
	// Half hours
	IBOutlet NSButton *tenAM;
	IBOutlet NSButton *elevenAM;
	IBOutlet NSButton *twelvePM;
	IBOutlet NSButton *onePM;
	IBOutlet NSButton *twoPM;
	IBOutlet NSButton *threePM;
	IBOutlet NSButton *fourPM;

}

// Add or delete table rows
- (IBAction)addRow:(id)sender;
- (IBAction)deleteRow:(id)sender;

// Make schedule!
- (IBAction)makeSchedule:(id)sender;

@end
