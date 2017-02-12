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
	
	self = [super init];
	timeEntries = @{@"10:00 am" : [NSNumber numberWithDouble:10.0],
					@"10:30 am" : [NSNumber numberWithDouble:10.5],
					@"11:00 am" : [NSNumber numberWithDouble:11.0],
					@"11:30 am" : [NSNumber numberWithDouble:11.5],
					@"12:00 pm" : [NSNumber numberWithDouble:12.0],
					@"12:30 pm" : [NSNumber numberWithDouble:12.5],
					@"1:00 pm" : [NSNumber numberWithDouble:13.0],
					@"1:30 pm" : [NSNumber numberWithDouble:13.5],
					@"2:00 pm" : [NSNumber numberWithDouble:14.0],
					@"2:30 pm" : [NSNumber numberWithDouble:14.5],
					@"3:00 pm" : [NSNumber numberWithDouble:15.0],
					@"3:30 pm" : [NSNumber numberWithDouble:15.5],
					@"4:00 pm" : [NSNumber numberWithDouble:16.0],
					@"4:30 pm" : [NSNumber numberWithDouble:16.5],
					@"5:00 pm" : [NSNumber numberWithDouble:17.0]};
	return self;
	
}

// Find the number of floor staff entered via the UI
- (int)countNumStaff:(NSMutableArray *)names {
	int counter = 0;
	for (int i = 0; i < names.count; i++) {
		if (![names[i] isEqualToString:@""]) {
			counter++;
		}
	}
	return counter;
}

// Check that end time comes after the start time for each shift
// Returns which row caused a problem (row index + 1); returns 0 if completely valid
- (int)checkShiftTimesFor:(int)n starts:(NSMutableArray *)startTimeData ends:(NSMutableArray *)endTimeData {
	
	// Check each start time >= end time
	for (int i = 0; i < n; i++) {
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
- (int)checkSpecialStationTimesFor:(int)n startsAndEnds:(NSMutableArray *)specificStationsData {
	
	//Check each start time >= end times
	double start_num;
	double end_num;
	for (int i = 0; i < n; i++) {
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

@end