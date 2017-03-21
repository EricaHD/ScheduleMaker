//
//  AppDelegate.m
//  ScheduleMaker
//
//  Created by Erica Dominic on 12/26/16.
//  Copyright © 2016 Erica Dominic. All rights reserved.
//

#import "AppDelegate.h"
#import "DatabaseViewController.h"
#import "RequirementsViewController.h"
#import "ScheduleViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

// Insert code here to initialize your application
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	
	// No work
	
}

// Sent by the default notification center immediately after the application becomes active
- (void)applicationDidBecomeActive:(NSNotification *)notification {
	
	// Create and initialize the model that all view controllers will use
	self.model = [[Model alloc] init];
	self.model.nameData = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", nil];
	self.model.startTimeData = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", nil];
	self.model.endTimeData = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", nil];
	self.model.specificStationsData = [NSMutableArray arrayWithObjects:
							[NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", nil],
							[NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", nil],
							[NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", nil],
							[NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", nil],
							[NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", nil], nil];
	self.model.lunchData = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
	
	// Find the three view controllers (hardcoded to be three)
	DatabaseViewController *database;
	RequirementsViewController *requirements;
	ScheduleViewController *schedule;
	NSWindow *window = [[NSApplication sharedApplication] mainWindow];
	NSArray *viewControllerArray = window.contentViewController.childViewControllers;
	if (viewControllerArray.count == 3) {
		database = (DatabaseViewController *) viewControllerArray[0];
		requirements = (RequirementsViewController *) viewControllerArray[1];
		schedule = (ScheduleViewController *) viewControllerArray[2];
	}
	else {
		NSLog(@"Error: viewControllerArray.count != 3");
	}
	
	// Point each controller to the model created above
	database.model = self.model;
	requirements.model = self.model;
	schedule.model = self.model;
	
	// Reload the data now that the view controllers are hooked up to the model
	// and self.model.nameData.count is definitely > 0 (for the benefit of numberOfRowsInTableView method)
	[schedule.table reloadData];
	
	self.model.str = @"Hey"; // TESTING
	
}

// Insert code here to tear down your application
- (void)applicationWillTerminate:(NSNotification *)aNotification {

	// No work
	
}

@end