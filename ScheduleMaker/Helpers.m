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
+ (int)checkShiftTimesFor:(NSMutableArray *)startTimeData until:(NSMutableArray *)endTimeData {
	
	// Create sharedManager here so we can reference timeEntries dictionary
	MyManager *sharedManager = [MyManager sharedManager];
	
	// Check each start time >= end time
	for (int i = 0; i < startTimeData.count; i++) {
		int start_num = [[sharedManager.timeEntries objectForKey:startTimeData[i]] intValue];
		int end_num = [[sharedManager.timeEntries objectForKey:endTimeData[i]] intValue];
		if (start_num >= end_num) {
			[self showAlert:@"Invalid shift times" withDetails:[NSString stringWithFormat:@"Please check shift times in row #%d.", i+1]];
			return -1;
		}
	}
	
	return 0;

}

// Check that end time comes after the start time for each specific station entry; shows alert if this is not the case
+ (int)checkSpecificStationTimesFor:(NSMutableArray *)specificStationsData {

	// Create sharedManager here so we can reference timeEntries dictionary
	MyManager *sharedManager = [MyManager sharedManager];
	
	// Check each start time >= end times
	int start_num;
	int end_num;
	for (int i = 0; i < specificStationsData.count; i++) {
		NSMutableArray *cell_data = specificStationsData[i];
		if (![cell_data[0] isEqualToString:@""]) {
			start_num = [[sharedManager.timeEntries objectForKey:cell_data[1]] intValue];
			end_num = [[sharedManager.timeEntries objectForKey:cell_data[2]] intValue];
			if (start_num >= end_num) {
				[self showAlert:@"Invalid specific station times" withDetails:[NSString stringWithFormat:@"Please check specific station times in row #%d.", i+1]];
				return -1;
			}
		}
		if (![cell_data[3] isEqualToString:@""]) {
			start_num = [[sharedManager.timeEntries objectForKey:cell_data[4]] intValue];
			end_num = [[sharedManager.timeEntries objectForKey:cell_data[5]] intValue];
			if (start_num >= end_num) {
				[self showAlert:@"Invalid specific station times" withDetails:[NSString stringWithFormat:@"Please check specific station times in row #%d.", i+1]];
				return -1;
			}
		}
		if (![cell_data[6] isEqualToString:@""]) {
			start_num = [[sharedManager.timeEntries objectForKey:cell_data[7]] intValue];
			end_num = [[sharedManager.timeEntries objectForKey:cell_data[8]] intValue];
			if (start_num >= end_num) {
				[self showAlert:@"Invalid specific station times" withDetails:[NSString stringWithFormat:@"Please check specific station times in row #%d.", i+1]];
				return -1;
			}
		}
	}

	// Otherwise, all valid
	return 0;

}

// Check that specific station times are subsets of shift times; will show alert if there is an error
+ (int)checkShiftTimesAndSpecificiStationTimesFor:(NSMutableArray *)startTimeData until:(NSMutableArray *)endTimeData including:(NSMutableArray *)specificStationsData {

	// Create sharedManager here so we can reference timeEntries dictionary
	MyManager *sharedManager = [MyManager sharedManager];
	
	// Check each special shift time is a subset of entire shift time
	int start_station;
	int end_station;
	for (int i = 0; i < startTimeData.count; i++) {
		int start_shift = [[sharedManager.timeEntries objectForKey:startTimeData[i]] intValue];;
		int end_shift = [[sharedManager.timeEntries objectForKey:endTimeData[i]] intValue];
		NSMutableArray *cell_data = specificStationsData[i];
		if (![cell_data[0] isEqualToString:@""]) {
			start_station = [[sharedManager.timeEntries objectForKey:cell_data[1]] intValue];
			end_station = [[sharedManager.timeEntries objectForKey:cell_data[2]] intValue];
			if ((start_station < start_shift) || (end_station > end_shift)) {
				[self showAlert:@"Invalid specific station times" withDetails:[NSString stringWithFormat:@"Please check that specific station times do not extend outside shift hours in row #%d.", i+1]];
				return -1;
			}
		}
		if (![cell_data[3] isEqualToString:@""]) {
			start_station = [[sharedManager.timeEntries objectForKey:cell_data[4]] intValue];
			end_station = [[sharedManager.timeEntries objectForKey:cell_data[5]] intValue];
			if ((start_station < start_shift) || (end_station > end_shift)) {
				[self showAlert:@"Invalid specific station times" withDetails:[NSString stringWithFormat:@"Please check that specific station times do not extend outside shift hours in row #%d.", i+1]];
				return -1;
			}
		}
		if (![cell_data[6] isEqualToString:@""]) {
			start_station = [[sharedManager.timeEntries objectForKey:cell_data[7]] intValue];
			end_station = [[sharedManager.timeEntries objectForKey:cell_data[8]] intValue];
			if ((start_station < start_shift) || (end_station > end_shift)) {
				[self showAlert:@"Invalid specific station times" withDetails:[NSString stringWithFormat:@"Please check that specific station times do not extend outside shift hours in row #%d.", i+1]];
				return -1;
			}
		}
	}

	// Otherwise, all, valid
	return 0;

}

// Check that specific station times do not conflict; will show alert if there is an error
+ (int)checkSpecificStationTimesConflictsFor:(NSMutableArray *)specificStationsData {

	// Create sharedManager here so we can reference timeEntries dictionary
	MyManager *sharedManager = [MyManager sharedManager];
	
	// Check that specific station times do not conflict
	int start_num;
	int end_num;
	for (int i = 0; i < specificStationsData.count; i++) {
		NSInteger tally[14] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
		NSMutableArray *cell_data = specificStationsData[i];
		if (![cell_data[0] isEqualToString:@""]) {
			start_num = [[sharedManager.timeEntries objectForKey:cell_data[1]] intValue];
			end_num = [[sharedManager.timeEntries objectForKey:cell_data[2]] intValue];
			for (int j = start_num; j < end_num; j++) {
				tally[j]++;
			}
		}
		if (![cell_data[3] isEqualToString:@""]) {
			start_num = [[sharedManager.timeEntries objectForKey:cell_data[4]] intValue];
			end_num = [[sharedManager.timeEntries objectForKey:cell_data[5]] intValue];
			for (int j = start_num; j < end_num; j++) {
				tally[j]++;
			}
		}
		if (![cell_data[6] isEqualToString:@""]) {
			start_num = [[sharedManager.timeEntries objectForKey:cell_data[7]] intValue];
			end_num = [[sharedManager.timeEntries objectForKey:cell_data[8]] intValue];
			for (int j = start_num; j < end_num; j++) {
				tally[j]++;
			}
		}

		// Make sure person is not assigned to > 1 specific station at a time
		for (int k = 0; k < 14; k++) {
			if (tally[k] > 1) {
				[self showAlert:@"Invalid specific station times" withDetails:[NSString stringWithFormat:@"Please check that specific station times do not overlap in row #%d.", i+1]];
				return -1;
			}
		}

	}

	// Otherwise, all valid
	return 0;

}

@end