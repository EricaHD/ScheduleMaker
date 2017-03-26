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
	//self.model.stationList = [NSMutableArray arrayWithObjects:@"Trike", @"-1", @"Coro", @"Gallery", @"-1", @"0", @"Greeting", @"Lesson", @"Project", @"Security", @"Tours", @"Manager", @"Birthday", @"Other", nil]; // DEFAULTS (order)
	self.model.stationList = [NSMutableArray arrayWithObjects:@"Trike", @"Coro", @"Gallery", @"-1", @"-1", @"-1", @"0", @"0", @"0", @"Float", @"Float", @"Project", @"Project", @"Greeting", @"Security", @"Tours", @"Lesson", @"Manager", @"Birthday", @"Other", nil]; // DEFAULTS (order)
	self.model.stationData = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
	self.model.stationStartTimeData = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil];
	self.model.stationEndTimeData = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil];
	self.model.stationFrequencyData = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil];
	
	// Set up checkboxes on the right side of RequirementsViewController
	self.model.halfHourData = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil]; // DEFAULT
	self.model.stackLunchesData = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil]; // DEFAULT?
	
	// Set up DatabaseViewController table
	self.model.staffNames = [NSMutableArray arrayWithObjects:@"Gemma", @"Ian", nil]; // DEFAULT OR PERSISTENT DATA
	self.model.staffQualifications = [NSMutableArray arrayWithObjects:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], nil], [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], nil], nil]; // DEFAULT OR PERSISTENT DATA
	
}

// Sent by the default notification center immediately after the application becomes active
- (void)applicationDidBecomeActive:(NSNotification *)notification {
	
	// If the model has not been made yet (so only do once)...
	if (self.model == nil) {
		
		// ...create the model that all view controllers will share
		self.model = [[Model alloc] init];
		
		// Set up arrays in model
		[self setUpModelsArrays];
		
		// Find and set title of window
		NSWindow *window = [[NSApplication sharedApplication] mainWindow];
		window.title = @"MoMath Floor Schedule Generator";
		
		// Find the three view controllers (hardcoded to be three)
		DatabaseViewController *database;
		RequirementsViewController *requirements;
		ScheduleViewController *schedule;
		NSDate* date = [NSDate date];
		while (TRUE) {
			// Ready to do the work
			if (window.contentViewController.childViewControllers.count == 3) {
				NSArray *viewControllerArray = window.contentViewController.childViewControllers;
				database = (DatabaseViewController *) viewControllerArray[0];
				requirements = (RequirementsViewController *) viewControllerArray[1];
				schedule = (ScheduleViewController *) viewControllerArray[2];
				break;
			}
			// Condition is not reached before timeout (giving program 5 seconds to get this while loop done)
			if ([date timeIntervalSinceNow] < -5) {
				break;
			}
			// Suspend thread execution for 10,000 microseconds = 0.01 seconds
			usleep(10000);
		}

		// Point each controller to the model created above
		database.model = self.model;
		requirements.model = self.model;
		schedule.model = self.model;
		
		// Reload tables now that the view controllers are hooked up to the model
		// So that numberOfRowsInTableView method can return something > 0
		// Also reload checkboxes on the side of the requirements view controller
		[schedule.table reloadData];
		[requirements.table reloadData];
		[database.table reloadData];
		[requirements reloadHalfHourData];
		[requirements reloadStackLunchesData];
		
	}
	
}

// Insert code here to tear down your application
- (void)applicationWillTerminate:(NSNotification *)aNotification {
	
}

@end