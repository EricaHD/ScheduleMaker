//
//  Model.m
//  ScheduleMaker
//
//  Created by Erica Dominic on 2/9/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import "Model.h"
#import "MyManager.h"
#import "ErrorChecking.h"
#import "Printing.h"

@interface Model ()

// The schedule
@property (strong) NSMutableArray *schedule;

// Hidden arrays from ScheduleViewController table (empty rows removed for ease of calculation in these methods)
@property (strong) NSMutableArray *names;
@property (strong) NSMutableArray *starts;
@property (strong) NSMutableArray *ends;
@property (strong) NSMutableArray *specifics;
@property (strong) NSMutableArray *lunches;

@end

@implementation Model

// Initialize a model object
- (id)init {
	
	// Call super class init method
	self = [super init];
	
	// Initialize instance variables
	self.schedule = [NSMutableArray array];
	
	// Return
	return self;
	
}

// When "+" add row button is pressed on ScheduleViewController
- (void)addRow {
	
	[self.nameData addObject:@""];
	[self.startTimeData addObject:@""];
	[self.endTimeData addObject:@""];
	[self.specificStationsData addObject:[NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", nil]];
	[self.lunchData addObject:[NSNumber numberWithInt:0]];
	
}

// When "-" delete row button is pressed on ScheduleViewController
- (void)deleteRow {
	
	if (self.nameData.count == 0) {
		return;
	}
	
	[self.nameData removeLastObject];
	[self.startTimeData removeLastObject];
	[self.endTimeData removeLastObject];
	[self.specificStationsData removeLastObject];
	[self.lunchData removeLastObject];
	
}

#pragma mark Methods that Make Schedule ########################################

// Set up hours/half hours on schedule using self.halfHourData
- (void)setHalfHours {
	
	for (int i = 0; i < self.halfHourData.count; i++) {
		if ([self.halfHourData[i] intValue] == 0) {
			// 2i + 1 should say "SAME"
			for (int j = 0; j < self.schedule.count; j++) {
				self.schedule[j][2*i+1] = @"SAME";
			}
		}
	}
	
	return;
	
}

// X out hours that are outside a staff member's shift using self.starts and self.ends
- (void)blockOutNonShiftHours {
	
	// Create sharedManager here so we can reference timeEntries dictionary
	MyManager *sharedManager = [MyManager sharedManager];
	
	for (int i = 0; i < self.starts.count; i++) {
		int start_num = [[sharedManager.timeEntries objectForKey:self.starts[i]] intValue];
		int end_num = [[sharedManager.timeEntries objectForKey:self.ends[i]] intValue];
		for (int j = 0; j < start_num; j++) {
			self.schedule[i][j] = @"X";
		}
		// If we have "X" then "SAME" delete the "SAME" so "X" doesn't extend further than necessary
		int next = MAX(start_num, 0);
		if (next < 14 && [self.schedule[i][next] isEqualToString:@"SAME"]) {
			self.schedule[i][next] = @"";
		}
		for (int k = end_num; k < 14; k++) {
			self.schedule[i][k] = @"X";
		}
	}
	
	return;
	
}

// Assign specific stations on schedule using self.specifics
- (void)assignSpecificStations {
	
	// Create sharedManager here so we can reference timeEntries dictionary
	MyManager *sharedManager = [MyManager sharedManager];
	
	for (int i = 0; i < self.specifics.count; i++) {
		int start_num;
		int end_num;
		NSMutableArray *cell_data = self.specifics[i];
		
		// Insert specific station #1 into schedule (if nonempty)
		if (![cell_data[0] isEqualToString:@""]) {
			start_num = [[sharedManager.timeEntries objectForKey:cell_data[1]] intValue];
			end_num = [[sharedManager.timeEntries objectForKey:cell_data[2]] intValue];
			for (int j = start_num; j < end_num; j++) {
				self.schedule[i][j] = cell_data[0];
			}
			if (end_num < 14 && [self.schedule[i][end_num] isEqualToString:@"SAME"]) {
				self.schedule[i][end_num] = @"";
			}
		}
		
		// Insert specific station #2 into schedule (if nonempty)
		if (![cell_data[3] isEqualToString:@""]) {
			start_num = [[sharedManager.timeEntries objectForKey:cell_data[4]] intValue];
			end_num = [[sharedManager.timeEntries objectForKey:cell_data[5]] intValue];
			for (int j = start_num; j < end_num; j++) {
				self.schedule[i][j] = cell_data[3];
			}
			if (end_num < 14 && [self.schedule[i][end_num] isEqualToString:@"SAME"]) {
				self.schedule[i][end_num] = @"";
			}
		}
		
		// Insert specific station #2 into schedule (if nonempty)
		if (![cell_data[6] isEqualToString:@""]) {
			start_num = [[sharedManager.timeEntries objectForKey:cell_data[7]] intValue];
			end_num = [[sharedManager.timeEntries objectForKey:cell_data[8]] intValue];
			for (int j = start_num; j < end_num; j++) {
				self.schedule[i][j] = cell_data[6];
			}
			if (end_num < 14 && [self.schedule[i][end_num] isEqualToString:@"SAME"]) {
				self.schedule[i][end_num] = @"";
			}
		}
	}
	
	return;
	
}

// Assign lunches on schedule using self.lunchData, self.stackLunchesData (and self.endTimeData - self.startTimeData > 5.5 check)
- (void)assignLunches {
	
	// Create sharedManager here so we can reference timeEntries dictionary
	MyManager *sharedManager = [MyManager sharedManager];
	
	// For each staff member...
	for (int i = 0; i < self.starts.count; i++) {
		
		// Figure out number of hours worked
		int start_num = [[sharedManager.timeEntries objectForKey:self.starts[i]] intValue];
		int end_num = [[sharedManager.timeEntries objectForKey:self.ends[i]] intValue];
		float hours_worked = ((float)(end_num - start_num)) / 2.0;
		
		// Figure out if lunch has been scheduled already
		BOOL scheduled_already = [self.schedule[i][2] isEqualToString:@"Lunch"] || [self.schedule[i][3] isEqualToString:@"Lunch"] ||
								 [self.schedule[i][4] isEqualToString:@"Lunch"] || [self.schedule[i][5] isEqualToString:@"Lunch"] ||
								 [self.schedule[i][6] isEqualToString:@"Lunch"] || [self.schedule[i][7] isEqualToString:@"Lunch"];
		
		// If staff member works >= 5.5 hours and lunch is not already scheduled...
		if (hours_worked >= 5.5 && !scheduled_already) {
			
			// Gather lunch slot probabilities
			int lunchSlots[6] = {0, 0, 0, 0, 0, 0};
			// Early lunch preference (weight: 1)
			if (1 & [self.lunches[i] integerValue]) {
				lunchSlots[0] += 1;
				lunchSlots[1] += 1;
			}
			// Late lunch preference (weight: 1)
			if (2 & [self.lunches[i] integerValue]) {
				lunchSlots[4] += 1;
				lunchSlots[5] += 1;
			}
			// Stacked lunches preferences (weight: 3)
			for (int j = 0; j < 6; j++) {
				if ([self.stackLunchesData[j] integerValue]) {
					lunchSlots[j] += 3;
				}
			}
			// Busy at that time
			for (int j = 0; j < 6; j++) {
				if (![self.schedule[i][j+2] isEqualToString:@""]) {
					lunchSlots[j] = 0;
				}
			}
			// Calculate total
			int total = 0;
			for (int j = 0; j < 6; j++) {
				total += lunchSlots[j];
			}
			// Generate random integer in [1, total]
			NSInteger random = arc4random_uniform(total) + 1;
			NSLog(@"Random: %lu", random);
			// Turn lunch slot array into cummulative array
			int so_far = 0;
			for (int j = 0; j < 6; j++) {
				so_far += lunchSlots[j];
				lunchSlots[j] = so_far;
			}
			// Calculate which lunch slot {0, 1, 2, 3, 4, 5} the random integer points to
			int slot = 0;
			while (lunchSlots[slot] < random) {
				slot++;
			}
			// Assign lunch at that slot for that employee
			self.schedule[i][slot + 2] = @"Lumch";
			
		}
	
	}
	
	// TODO: now that all employees have been assigned a lunch, check global stats against global expectations
	// TODO: Take hour lunch option into account (4 & [self.lunches[i] integerValue])
	
	return;
	
}

// Does the calculations needed to actually make the schedule; data already collected
- (void)makeSchedule {
	
	// Make copies of arrays
	self.names = [NSMutableArray arrayWithArray:self.nameData];
	self.starts = [NSMutableArray arrayWithArray:self.startTimeData];
	self.ends = [NSMutableArray arrayWithArray:self.endTimeData];
	self.specifics = [NSMutableArray arrayWithArray:self.specificStationsData];
	self.lunches = [NSMutableArray arrayWithArray:self.lunchData];
	
	// Take rows out of ScheduleViewController table that have no name in the name column
	NSMutableIndexSet *indexes = [[NSMutableIndexSet alloc] init];
	for (int i = 0; i < self.names.count; i++) {
		if ([self.names[i] isEqualToString:@""]) {
			[indexes addIndex:i];
		}
	}
	[self.names removeObjectsAtIndexes:indexes];
	[self.starts removeObjectsAtIndexes:indexes];
	[self.ends removeObjectsAtIndexes:indexes];
	[self.specifics removeObjectsAtIndexes:indexes];
	[self.lunches removeObjectsAtIndexes:indexes];
	
	// If make schedule has been pressed before, there is an old array that must be cleared
	[self.schedule removeAllObjects];
	
	// Note: self.names.count is now the number of employees
	// So we can set the dimensions of schedule array
	for (int i = 0; i < self.names.count; i++) {
		[self.schedule addObject:[NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil]];
	}
	
	// Error checking: start time < end time for each shift
	int result1 = [ErrorChecking checkShiftTimesFor:self.starts until:self.ends];
	
	// Error checking: start time < end time for each specific station entry
	int result2 = [ErrorChecking checkSpecificStationTimesFor:self.specifics];
	
	// Error checking: specific station times are subsets of shift times
	int result3 = [ErrorChecking checkShiftTimesAndSpecificiStationTimesFor:self.starts until:self.ends including:self.specifics];
	
	// Error checking: specific station times do not conflict
	int result4 = [ErrorChecking checkSpecificStationTimesConflictsFor:self.specificStationsData];
	
	// If any of the above error checks have caught errors, do not make schedule (i.e. end here)
	if (result1 + result2 + result3 + result4 != 0) {
		return;
	}
	
	// Set up hours/half hours on schedule
	[self setHalfHours];
	
	// X out hours that are outside a staff member's shift
	[self blockOutNonShiftHours];
	
	// Assign specific stations on schedule
	[self assignSpecificStations];
	
	// Assign lunches on schedule
	[self assignLunches];
	
	// DEBUGGING
	//[Printing printScheduleData:self.nameData withStart:self.startTimeData withEnd:self.endTimeData withSpecifics:self.specificStationsData withLunch:self.lunchData];
	//[Printing printRequirementsData:self.stationList withChecks:self.stationData withStart:self.stationStartTimeData withEnd:self.stationEndTimeData withFrequency:self.stationFrequencyData withHalfHours:self.halfHourData withStackLunches:self.stackLunchesData];
	[Printing printSchedule:self.schedule withNames:self.names];
	
}

@end
