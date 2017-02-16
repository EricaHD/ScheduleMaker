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
	timeEntries = @{@"10:00 am" : [NSNumber numberWithDouble:10.0], // 20 - 20
					@"10:30 am" : [NSNumber numberWithDouble:10.5], // 21 - 20
					@"11:00 am" : [NSNumber numberWithDouble:11.0], // 22 - 20
					@"11:30 am" : [NSNumber numberWithDouble:11.5], // 23 - 20
					@"12:00 pm" : [NSNumber numberWithDouble:12.0], // 24 - 20
					@"12:30 pm" : [NSNumber numberWithDouble:12.5], // 25 - 20
					@"1:00 pm" : [NSNumber numberWithDouble:13.0], // 26 - 20
					@"1:30 pm" : [NSNumber numberWithDouble:13.5], // 27 - 20
					@"2:00 pm" : [NSNumber numberWithDouble:14.0], // 28 - 20
					@"2:30 pm" : [NSNumber numberWithDouble:14.5], // 29 - 20
					@"3:00 pm" : [NSNumber numberWithDouble:15.0], // 30 - 20
					@"3:30 pm" : [NSNumber numberWithDouble:15.5], // 31 - 20
					@"4:00 pm" : [NSNumber numberWithDouble:16.0], // 32 - 20
					@"4:30 pm" : [NSNumber numberWithDouble:16.5], // 33 - 20
					@"5:00 pm" : [NSNumber numberWithDouble:17.0]};
	numStaff = 0;
	schedule = [NSMutableArray array];
	
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
		double start_num = [[timeEntries objectForKey:startTimeData[i]] doubleValue];
		double end_num = [[timeEntries objectForKey:endTimeData[i]] doubleValue];
		if (start_num >= end_num) {
			return (i+1);
		}
	}
	
	// Otherwise, all valid
	return 0;
	
}

// Check that end time comes after the start time for each specific station entry
- (int)checkSpecialStationTimesFor:(NSMutableArray *)specificStationsData {
	
	//Check each start time >= end times
	double start_num;
	double end_num;
	for (int i = 0; i < numStaff; i++) {
		NSMutableArray *cell_data = specificStationsData[i];
		if (![cell_data[0] isEqualToString:@""]) {
			start_num = [[timeEntries objectForKey:cell_data[1]] doubleValue];
			end_num = [[timeEntries objectForKey:cell_data[2]] doubleValue];
			if (start_num >= end_num) {
				return (i+1);
			}
		}
		if (![cell_data[3] isEqualToString:@""]) {
			start_num = [[timeEntries objectForKey:cell_data[4]] doubleValue];
			end_num = [[timeEntries objectForKey:cell_data[5]] doubleValue];
			if (start_num >= end_num) {
				return (i+1);
			}
		}
		if (![cell_data[6] isEqualToString:@""]) {
			start_num = [[timeEntries objectForKey:cell_data[7]] doubleValue];
			end_num = [[timeEntries objectForKey:cell_data[8]] doubleValue];
			if (start_num >= end_num) {
				return (i+1);
			}
		}
	}
	
	// Otherwise, all valid
	return 0;
}

- (void)printSchedule:(NSMutableArray *)nameData {
	
	// Print contents of schedule
	NSLog(@"%@", [NSString stringWithFormat:@"%-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %s", [@"" UTF8String], [@"10:00 am" UTF8String], [@"10:30 am" UTF8String], [@"11:00 am" UTF8String], [@"11:30 am" UTF8String], [@"12:00 pm" UTF8String], [@"12:30 pm" UTF8String], [@"1:00 pm" UTF8String], [@"1:30 pm" UTF8String], [@"2:00 pm" UTF8String], [@"2:30 pm" UTF8String], [@"3:00 pm" UTF8String], [@"3:30 pm" UTF8String], [@"4:00 pm" UTF8String], [@"4:30 pm" UTF8String]]);
	for (int i = 0; i < numStaff; i++) {
		NSLog(@"%@", [NSString stringWithFormat:@"%-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %s", [nameData[i] UTF8String], [schedule[i][0] UTF8String], [schedule[i][1] UTF8String], [schedule[i][2] UTF8String], [schedule[i][3] UTF8String], [schedule[i][4] UTF8String], [schedule[i][5] UTF8String], [schedule[i][6] UTF8String], [schedule[i][7] UTF8String], [schedule[i][8] UTF8String], [schedule[i][9] UTF8String], [schedule[i][10] UTF8String], [schedule[i][11] UTF8String], [schedule[i][12] UTF8String], [schedule[i][13] UTF8String]]);
	}
	
	
}

@end