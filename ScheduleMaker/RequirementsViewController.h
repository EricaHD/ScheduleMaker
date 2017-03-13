//
//  RequirementsViewController.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 3/11/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// Constants
#define ROW_HEIGHT_2 25.0;

@interface RequirementsViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource> {
	
	// Table
	NSMutableArray *stationList;
	NSMutableArray *stationData;
	NSMutableArray *startTimeData;
	NSMutableArray *endTimeData;
	NSMutableArray *frequencyData;
	IBOutlet NSTableView *table;
	
	// Half hours
	IBOutlet NSButton *tenAM;
	IBOutlet NSButton *elevenAM;
	IBOutlet NSButton *twelvePM;
	IBOutlet NSButton *onePM;
	IBOutlet NSButton *twoPM;
	IBOutlet NSButton *threePM;
	IBOutlet NSButton *fourPM;
	
	// Stack lunches
	IBOutlet NSButton *firstLunch;
	IBOutlet NSButton *secondLunch;
	IBOutlet NSButton *thirdLunch;
	IBOutlet NSButton *fourthLunch;
	IBOutlet NSButton *fifthLunch;
	IBOutlet NSButton *sixthLunch;
	
}

@end