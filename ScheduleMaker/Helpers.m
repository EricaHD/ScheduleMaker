//
//  Helpers.m
//  ScheduleMaker
//
//  Created by Erica Dominic on 3/22/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Helpers.h"
#import "MyManager.h"

@interface Helpers ()

@end

@implementation Helpers

// Initialize a model object
- (id)init {
	
	// Call super class init method
	self = [super init];
	
	// Return
	return self;
	
}

// Show alert with specified message
+ (void)showAlert:(NSString *)title withDetails:(NSString *)details {
	
	NSAlert *alert = [[NSAlert alloc] init];
	[alert addButtonWithTitle:@"OK"];
	[alert setMessageText:title];
	[alert setInformativeText:details];
	[alert setAlertStyle:NSInformationalAlertStyle];
	NSWindow *window = [[NSApplication sharedApplication] mainWindow];
	[alert beginSheetModalForWindow:window completionHandler:nil];

}

// Check that end time comes after the start time for each shift; shows alert if this is not the case
+ (void)checkShiftTimesFor:(NSMutableArray *)startTimeData until:(NSMutableArray *)endTimeData {
	
	// Create sharedManager here so we can reference timeEntries dictionary
	MyManager *sharedManager = [MyManager sharedManager];
	
	// Check each start time >= end time
	for (int i = 0; i < startTimeData.count; i++) {
		int start_num = [[sharedManager.timeEntries objectForKey:startTimeData[i]] intValue];
		int end_num = [[sharedManager.timeEntries objectForKey:endTimeData[i]] intValue];
		if (start_num >= end_num) {
			[self showAlert:@"Invalid shift times" withDetails:[NSString stringWithFormat:@"Please check shift times in row #%d.", i+1]];
		}
	}

}

@end