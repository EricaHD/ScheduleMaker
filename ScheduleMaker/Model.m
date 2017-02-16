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
//	timeEntries = @{@"10:00 am" : [NSNumber numberWithDouble:10.0],
//					@"10:30 am" : [NSNumber numberWithDouble:10.5],
//					@"11:00 am" : [NSNumber numberWithDouble:11.0],
//					@"11:30 am" : [NSNumber numberWithDouble:11.5],
//					@"12:00 pm" : [NSNumber numberWithDouble:12.0],
//					@"12:30 pm" : [NSNumber numberWithDouble:12.5],
//					@"1:00 pm" : [NSNumber numberWithDouble:13.0],
//					@"1:30 pm" : [NSNumber numberWithDouble:13.5],
//					@"2:00 pm" : [NSNumber numberWithDouble:14.0],
//					@"2:30 pm" : [NSNumber numberWithDouble:14.5],
//					@"3:00 pm" : [NSNumber numberWithDouble:15.0],
//					@"3:30 pm" : [NSNumber numberWithDouble:15.5],
//					@"4:00 pm" : [NSNumber numberWithDouble:16.0],
//					@"4:30 pm" : [NSNumber numberWithDouble:16.5],
//					@"5:00 pm" : [NSNumber numberWithDouble:17.0]};
	timeEntries = @{@"10:00 am" : [NSNumber numberWithDouble:0],
					@"10:30 am" : [NSNumber numberWithDouble:1],
					@"11:00 am" : [NSNumber numberWithDouble:2],
					@"11:30 am" : [NSNumber numberWithDouble:3],
					@"12:00 pm" : [NSNumber numberWithDouble:4],
					@"12:30 pm" : [NSNumber numberWithDouble:5],
					@"1:00 pm" : [NSNumber numberWithDouble:6],
					@"1:30 pm" : [NSNumber numberWithDouble:7],
					@"2:00 pm" : [NSNumber numberWithDouble:8],
					@"2:30 pm" : [NSNumber numberWithDouble:9],
					@"3:00 pm" : [NSNumber numberWithDouble:10],
					@"3:30 pm" : [NSNumber numberWithDouble:11],
					@"4:00 pm" : [NSNumber numberWithDouble:12],
					@"4:30 pm" : [NSNumber numberWithDouble:13],
					@"5:00 pm" : [NSNumber numberWithDouble:14]};
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

// X out hours that are outside a staff member's shift
- (void)blockOutNonShiftHours:(NSMutableArray *)startTimeData until:(NSMutableArray *)endTimeData {
	
	for (int i = 0; i < numStaff; i++) {
		double start_num = [[timeEntries objectForKey:startTimeData[i]] doubleValue]; // 0
		double end_num = [[timeEntries objectForKey:endTimeData[i]] doubleValue]; // 14
		for (int j = 0; j < start_num; j++) {
			schedule[i][j] = @"X";
		}
		for (int k = end_num; k < 14; k++) {
			schedule[i][k] = @"X";
		}
	}
	
}

// Print schedule array, formated next to names and times for easy viewing and debugging
- (void)printSchedule:(NSMutableArray *)nameData {
	
	// Print contents of schedule
	NSLog(@"%@", [NSString stringWithFormat:@"%-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %s", [@"" UTF8String], [@"10:00 am" UTF8String], [@"10:30 am" UTF8String], [@"11:00 am" UTF8String], [@"11:30 am" UTF8String], [@"12:00 pm" UTF8String], [@"12:30 pm" UTF8String], [@"1:00 pm" UTF8String], [@"1:30 pm" UTF8String], [@"2:00 pm" UTF8String], [@"2:30 pm" UTF8String], [@"3:00 pm" UTF8String], [@"3:30 pm" UTF8String], [@"4:00 pm" UTF8String], [@"4:30 pm" UTF8String]]);
	for (int i = 0; i < numStaff; i++) {
		NSLog(@"%@", [NSString stringWithFormat:@"%-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %s", [nameData[i] UTF8String], [schedule[i][0] UTF8String], [schedule[i][1] UTF8String], [schedule[i][2] UTF8String], [schedule[i][3] UTF8String], [schedule[i][4] UTF8String], [schedule[i][5] UTF8String], [schedule[i][6] UTF8String], [schedule[i][7] UTF8String], [schedule[i][8] UTF8String], [schedule[i][9] UTF8String], [schedule[i][10] UTF8String], [schedule[i][11] UTF8String], [schedule[i][12] UTF8String], [schedule[i][13] UTF8String]]);
	}
	
}

@end