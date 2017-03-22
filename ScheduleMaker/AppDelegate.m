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
	
	// Nothing
	
}

// Set up arrays in model
- (void)setUpModelsArrays {
	
	// Set up ScheduleViewController table
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
	
	// Set up RequirementsViewController table
	self.model.stationList = [NSMutableArray arrayWithObjects:@"Trike", @"-1", @"Coro", @"Gallery", @"-1", @"0", @"Greeting", @"Lesson", @"Project", @"Security", @"Tours", @"Manager", @"Birthday", @"Other", nil]; // DEFAULTS (order)
	self.model.stationData = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
	self.model.stationStartTimeData = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil];
	self.model.stationEndTimeData = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil];
	self.model.stationFrequencyData = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil];
	
	// Set up checkboxes on the right side of RequirementsViewController
	self.model.halfHourData = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil]; // DEFAULT
	self.model.stackLunchesData = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]; // DEFAULT?
	
}

// Sent by the default notification center immediately after the application becomes active
- (void)applicationDidBecomeActive:(NSNotification *)notification {
	
	// If the model has not been made yet (so only do once)...
	if (self.model == nil) {
		
		// ...create the model that all view controllers will share
		self.model = [[Model alloc] init];
		
		// Set up arrays in model
		[self setUpModelsArrays];
		
		// Find the three view controllers (hardcoded to be three)
		DatabaseViewController *database;
		RequirementsViewController *requirements;
		ScheduleViewController *schedule;
		NSWindow *window = [[NSApplication sharedApplication] mainWindow];
		NSArray *viewControllerArray = window.contentViewController.childViewControllers;
		if (viewControllerArray.count == 3) { // TODO
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
	
		// Reload tables now that the view controllers are hooked up to the model
		// So that numberOfRowsInTableView method can return something > 0
		[schedule.table reloadData];
		[requirements.table reloadData];
	
		// Reload checkboxes on the side of the requirements view controller
		[requirements reloadHalfHourData];
		[requirements reloadStackLunchesData];
		
	}
	
}

// Insert code here to tear down your application
- (void)applicationWillTerminate:(NSNotification *)aNotification {

	// Nothing
	
}

@end