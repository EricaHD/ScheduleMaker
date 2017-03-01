//
//  Model.m
//  ScheduleMaker
//
//  Created by Erica Dominic on 2/9/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import "Model.h"

@implementation Model

// Initialize a model object
- (id)init {
	
	// Call super class init method
	self = [super init];
	
	// Initialize instance variables
	timeEntries = @{@"10:00 am" : [NSNumber numberWithInt:0],
					@"10:30 am" : [NSNumber numberWithInt:1],
					@"11:00 am" : [NSNumber numberWithInt:2],
					@"11:30 am" : [NSNumber numberWithInt:3],
					@"12:00 pm" : [NSNumber numberWithInt:4],
					@"12:30 pm" : [NSNumber numberWithInt:5],
					@"1:00 pm" : [NSNumber numberWithInt:6],
					@"1:30 pm" : [NSNumber numberWithInt:7],
					@"2:00 pm" : [NSNumber numberWithInt:8],
					@"2:30 pm" : [NSNumber numberWithInt:9],
					@"3:00 pm" : [NSNumber numberWithInt:10],
					@"3:30 pm" : [NSNumber numberWithInt:11],
					@"4:00 pm" : [NSNumber numberWithInt:12],
					@"4:30 pm" : [NSNumber numberWithInt:13],
					@"5:00 pm" : [NSNumber numberWithInt:14]};
	numStaff = 0;
	schedule = [NSMutableArray array];
	NSInteger lunchCount[14] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}; // TODO
	
	// Return
	return self;
	
}

// Count and record the number of floor staff entered via the UI; also adjusts size of schedule array
- (void)setNumStaff:(NSMutableArray *)names {
	
	// Count number of entries in names column
	int counter = 0;
	for (int i = 0; i < names.count; i++) {
		if (![names[i] isEqualToString:@""]) {
			counter++;
		}
	}
	numStaff = counter;
	
	// Set dimensions of schedule array
	for (int i = 0; i < numStaff; i++) {
		[schedule addObject:[NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil]];
	}
	
	return;

}

// Return the number of floor staff entered via the UI
- (int)getNumStaff {
	
	return numStaff;

}

// Check that end time comes after the start time for each shift
// Returns which row caused a problem (row index + 1); returns 0 if completely valid
- (int)checkShiftTimesFor:(NSMutableArray *)startTimeData until:(NSMutableArray *)endTimeData {
	
	// Check each start time >= end time
	for (int i = 0; i < numStaff; i++) {
		int start_num = [[timeEntries objectForKey:startTimeData[i]] intValue];
		int end_num = [[timeEntries objectForKey:endTimeData[i]] intValue];
		if (start_num >= end_num) {
			return (i+1);
		}
	}
	
	// Otherwise, all valid
	return 0;
	
}

// Check that end time comes after the start time for each specific station entry
- (int)checkSpecificStationTimesFor:(NSMutableArray *)specificStationsData {
	
	// Check each start time >= end times
	int start_num;
	int end_num;
	for (int i = 0; i < numStaff; i++) {
		NSMutableArray *cell_data = specificStationsData[i];
		if (![cell_data[0] isEqualToString:@""]) {
			start_num = [[timeEntries objectForKey:cell_data[1]] intValue];
			end_num = [[timeEntries objectForKey:cell_data[2]] intValue];
			if (start_num >= end_num) {
				return (i+1);
			}
		}
		if (![cell_data[3] isEqualToString:@""]) {
			start_num = [[timeEntries objectForKey:cell_data[4]] intValue];
			end_num = [[timeEntries objectForKey:cell_data[5]] intValue];
			if (start_num >= end_num) {
				return (i+1);
			}
		}
		if (![cell_data[6] isEqualToString:@""]) {
			start_num = [[timeEntries objectForKey:cell_data[7]] intValue];
			end_num = [[timeEntries objectForKey:cell_data[8]] intValue];
			if (start_num >= end_num) {
				return (i+1);
			}
		}
	}
	
	// Otherwise, all valid
	return 0;
	
}

// Check that specific station times are subsets of shift times
- (int)checkShiftTimesAndSpecificiStationTimesFor:(NSMutableArray *)startTimeData until:(NSMutableArray *)endTimeData including:(NSMutableArray *)specificStationsData {
	
	// Check each
	int start_num;
	int end_num;
	for (int i = 0; i < numStaff; i++) {
		int start_shift = [[timeEntries objectForKey:startTimeData[i]] intValue];;
		int end_shift = [[timeEntries objectForKey:endTimeData[i]] intValue];
		NSMutableArray *cell_data = specificStationsData[i];
		if (![cell_data[0] isEqualToString:@""]) {
			start_num = [[timeEntries objectForKey:cell_data[1]] intValue];
			end_num = [[timeEntries objectForKey:cell_data[2]] intValue];
			if ((start_num < start_shift) || (end_num > end_shift)) {
				return (i+1);
			}
		}
		if (![cell_data[3] isEqualToString:@""]) {
			start_num = [[timeEntries objectForKey:cell_data[4]] intValue];
			end_num = [[timeEntries objectForKey:cell_data[5]] intValue];
			if ((start_num < start_shift) || (end_num > end_shift)) {
				return (i+1);
			}
		}
		if (![cell_data[6] isEqualToString:@""]) {
			start_num = [[timeEntries objectForKey:cell_data[7]] intValue];
			end_num = [[timeEntries objectForKey:cell_data[8]] intValue];
			if ((start_num < start_shift) || (end_num > end_shift)) {
				return (i+1);
			}
		}
	}
	
	// Otherwise, all, valid
	return 0;
	
}

// Check that specific station times do not conflict
- (int)checkSpecificStationTimesConflictsFor:(NSMutableArray *)specificStationsData {
	
	// Check that specific station times do not conflict
	int start_num;
	int end_num;
	for (int i = 0; i < numStaff; i++) {
		NSInteger tally[14] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
		NSMutableArray *cell_data = specificStationsData[i];
		if (![cell_data[0] isEqualToString:@""]) {
			start_num = [[timeEntries objectForKey:cell_data[1]] intValue];
			end_num = [[timeEntries objectForKey:cell_data[2]] intValue];
			for (int j = start_num; j < end_num; j++) {
				tally[j]++;
			}
		}
		if (![cell_data[3] isEqualToString:@""]) {
			start_num = [[timeEntries objectForKey:cell_data[4]] intValue];
			end_num = [[timeEntries objectForKey:cell_data[5]] intValue];
			for (int j = start_num; j < end_num; j++) {
				tally[j]++;
			}
		}
		if (![cell_data[6] isEqualToString:@""]) {
			start_num = [[timeEntries objectForKey:cell_data[7]] intValue];
			end_num = [[timeEntries objectForKey:cell_data[8]] intValue];
			for (int j = start_num; j < end_num; j++) {
				tally[j]++;
			}
		}
		
		// Make sure person is not assigned to > 1 specific station at a time
		for (int k = 0; k < 14; k++) {
			if (tally[k] > 1) {
				return (i+1);
			}
		}
		
	}
	
	// Otherwise, all valid
	return 0;
	
}

// Set up hours/half hours on schedule
- (void)setHalfHours:(NSMutableArray *)halfHourData {
	
	for (int i = 0; i < halfHourData.count; i++) {
		if (![halfHourData[i] intValue]) {
			// 2i + 1 should say "SAME"
			for (int j = 0; j < schedule.count; j++) {
				schedule[j][2*i+1] = @"SAME";
			}
		}
	}
	
	return;
}

// X out hours that are outside a staff member's shift
- (void)blockOutNonShiftHours:(NSMutableArray *)startTimeData until:(NSMutableArray *)endTimeData {
	
	for (int i = 0; i < numStaff; i++) {
		double start_num = [[timeEntries objectForKey:startTimeData[i]] doubleValue];
		double end_num = [[timeEntries objectForKey:endTimeData[i]] doubleValue];
		for (int j = 0; j < start_num; j++) {
			schedule[i][j] = @"X";
		}
		int next = start_num;
		// If we have "X" then "SAME" delete the "SAME" so "X" doesn't extend further than necessary
		if (next < 14 && [schedule[i][next] isEqualToString:@"SAME"]) {
			schedule[i][next] = @"";
		}
		for (int k = end_num; k < 14; k++) {
			schedule[i][k] = @"X";
		}
	}
	
	return;
	
}

// Assign specific stations on schedule
- (void)assignSpecificStations:(NSMutableArray *)specificStationsData {

	for (int i = 0; i < numStaff; i++) {
		
		// Prepare for and get specpfic stations cell information
		int start_num;
		int end_num;
		NSMutableArray *cell_data = specificStationsData[i];

		// Insert specific station #1 into schedule
		if (![cell_data[0] isEqualToString:@""]) {
			start_num = [[timeEntries objectForKey:cell_data[1]] intValue];
			end_num = [[timeEntries objectForKey:cell_data[2]] intValue];
			for (int j = start_num; j < end_num; j++) {
				schedule[i][j] = cell_data[0];
			}
		}
		if (end_num < 14 && [schedule[i][end_num] isEqualToString:@"SAME"]) {
			schedule[i][end_num] = @"";
		}
		
		// Insert specific station #2 into schedule
		if (![cell_data[3] isEqualToString:@""]) {
			start_num = [[timeEntries objectForKey:cell_data[4]] intValue];
			end_num = [[timeEntries objectForKey:cell_data[5]] intValue];
			for (int j = start_num; j < end_num; j++) {
				schedule[i][j] = cell_data[3];
			}
		}
		if (end_num < 14 && [schedule[i][end_num] isEqualToString:@"SAME"]) {
			schedule[i][end_num] = @"";
		}
		

		// Insert specific station #2 into schedule
		if (![cell_data[6] isEqualToString:@""]) {
			start_num = [[timeEntries objectForKey:cell_data[7]] intValue];
			end_num = [[timeEntries objectForKey:cell_data[8]] intValue];
			for (int j = start_num; j < end_num; j++) {
				schedule[i][j] = cell_data[6];
			}
		}
		if (end_num < 14 && [schedule[i][end_num] isEqualToString:@"SAME"]) {
			schedule[i][end_num] = @"";
		}

	}
	
	return;
	
}

// Assign lunches on schedule for staff members at the museum for > 5 hours
- (void)assignLunches:(NSMutableArray *)lunchData starting:(NSMutableArray *)startTimeData ending:(NSMutableArray *)endTimeData {
	
	// Early, late, and standard lunch lists
	// Lists contain ordered pairs: (person/row number, hour lunch state)
	NSMutableArray *earlyLunchList;
	NSMutableArray *standardLunchList;
	NSMutableArray *lateLunchList;
	
	// Go through all staff; compile data into above lunch lists
	for (int i = 0; i < numStaff; i++) {
		int start_num = [[timeEntries objectForKey:startTimeData[i]] intValue];
		int end_num = [[timeEntries objectForKey:endTimeData[i]] intValue];
		
		// Only needs a lunch if on duty for 5 or more hours (10 half hours) or more
		if (end_num - start_num >= 10) {
			NSNumber *cell_Data = lunchData[i];
			int early_lunch_state = 1 & [cell_Data integerValue];
			int late_lunch_state = 2 & [cell_Data integerValue];
			int hour_lunch_state = 4 & [cell_Data integerValue];
			if (early_lunch_state) {
				[earlyLunchList addObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:i], [NSNumber numberWithInt:hour_lunch_state], nil]];
			}
			else if (late_lunch_state) {
				[lateLunchList addObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:i], [NSNumber numberWithInt:hour_lunch_state], nil]];
			}
			else {
				[standardLunchList addObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:i], [NSNumber numberWithInt:hour_lunch_state], nil]];
			}
		}
	}
	
	// Assign early lunches from earlyLunchList
	for (int j = 0; j < earlyLunchList.count; j++) {
		NSNumber *row = earlyLunchList[j][0];
		NSNumber *hour_lunch_state = earlyLunchList[j][1];
		if (hour_lunch_state) {
			// TODO: person (row variable) wants early hour lunch
		}
		else {
			// TODO: person (row variable) wants early half-hour lunch
		}
	}
	
	// Assign late lunches from lateLunchList
	for (int j = 0; j < lateLunchList.count; j++) {
		NSNumber *row = earlyLunchList[j][0];
		NSNumber *hour_lunch_state = earlyLunchList[j][1];
		if (hour_lunch_state) {
			// TODO: person (row variable) wants late hour lunch
		}
		else {
			// TODO: person (row variable) wants late half-hour lunch
		}
	}
	
	// Assign rest of the lunches from standardLunchList
	for (int j = 0; j < standardLunchList.count; j++) {
		NSNumber *row = earlyLunchList[j][0];
		NSNumber *hour_lunch_state = earlyLunchList[j][1];
		if (hour_lunch_state) {
			// TODO: person (row variable) wants hour lunch
		}
		else {
			// TODO: person (row variable) wants half-hour lunch
		}
	}
	
	return;
}

// Print schedule array, formated next to names and times for easy viewing and debugging
- (void)printSchedule:(NSMutableArray *)nameData {
	
	// Print contents of schedule
	NSLog(@"%@", [NSString stringWithFormat:@"%-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %s", [@"" UTF8String], [@"10:00 am" UTF8String], [@"10:30 am" UTF8String], [@"11:00 am" UTF8String], [@"11:30 am" UTF8String], [@"12:00 pm" UTF8String], [@"12:30 pm" UTF8String], [@"1:00 pm" UTF8String], [@"1:30 pm" UTF8String], [@"2:00 pm" UTF8String], [@"2:30 pm" UTF8String], [@"3:00 pm" UTF8String], [@"3:30 pm" UTF8String], [@"4:00 pm" UTF8String], [@"4:30 pm" UTF8String]]);
	for (int i = 0; i < numStaff; i++) {
		NSLog(@"%@", [NSString stringWithFormat:@"%-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %s", [nameData[i] UTF8String], [schedule[i][0] UTF8String], [schedule[i][1] UTF8String], [schedule[i][2] UTF8String], [schedule[i][3] UTF8String], [schedule[i][4] UTF8String], [schedule[i][5] UTF8String], [schedule[i][6] UTF8String], [schedule[i][7] UTF8String], [schedule[i][8] UTF8String], [schedule[i][9] UTF8String], [schedule[i][10] UTF8String], [schedule[i][11] UTF8String], [schedule[i][12] UTF8String], [schedule[i][13] UTF8String]]);
	}
	
	return;
	
}

@end