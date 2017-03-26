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

@property (strong) NSMutableArray *schedule;

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

// X out hours that are outside a staff member's shift using self.startTimeData and self.endTimeData
- (void)blockOutNonShiftHours {
	
	// Create sharedManager here so we can reference timeEntries dictionary
	MyManager *sharedManager = [MyManager sharedManager];
	
	for (int i = 0; i < self.startTimeData.count; i++) {
		int start_num = [[sharedManager.timeEntries objectForKey:self.startTimeData[i]] intValue];
		int end_num = [[sharedManager.timeEntries objectForKey:self.endTimeData[i]] intValue];
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

// Assign specific stations on schedule using self.specificStationsData
- (void)assignSpecificStations {

	// Create sharedManager here so we can reference timeEntries dictionary
	MyManager *sharedManager = [MyManager sharedManager];
	
	for (int i = 0; i < self.specificStationsData.count; i++) {
		int start_num;
		int end_num;
		NSMutableArray *cell_data = self.specificStationsData[i];
		
		// Insert specific station #1 into schedule (if nonempty)
		if (![cell_data[0] isEqualToString:@""]) {
			start_num = [[sharedManager.timeEntries objectForKey:cell_data[1]] intValue];
			end_num = [[sharedManager.timeEntries objectForKey:cell_data[2]] intValue];
			for (int j = start_num; j < end_num; j++) {
				self.schedule[i][j] = cell_data[0];
			}
		}
		if (end_num < 14 && [self.schedule[i][end_num] isEqualToString:@"SAME"]) {
			self.schedule[i][end_num] = @"";
		}
		
		// Insert specific station #2 into schedule (if nonempty)
		if (![cell_data[3] isEqualToString:@""]) {
			start_num = [[sharedManager.timeEntries objectForKey:cell_data[4]] intValue];
			end_num = [[sharedManager.timeEntries objectForKey:cell_data[5]] intValue];
			for (int j = start_num; j < end_num; j++) {
				self.schedule[i][j] = cell_data[3];
			}
		}
		if (end_num < 14 && [self.schedule[i][end_num] isEqualToString:@"SAME"]) {
			self.schedule[i][end_num] = @"";
		}
		

		// Insert specific station #2 into schedule (if nonempty)
		if (![cell_data[6] isEqualToString:@""]) {
			start_num = [[sharedManager.timeEntries objectForKey:cell_data[7]] intValue];
			end_num = [[sharedManager.timeEntries objectForKey:cell_data[8]] intValue];
			for (int j = start_num; j < end_num; j++) {
				self.schedule[i][j] = cell_data[6];
			}
		}
		if (end_num < 14 && [self.schedule[i][end_num] isEqualToString:@"SAME"]) {
			self.schedule[i][end_num] = @"";
		}

	}
	
	return;
	
}

// Assign lunches on schedule using self.lunchData, self.stackLunchesData (and self.endTimeData - self.startTimeData > 5.5 check)
- (void)assignLunches {
	
	// Create sharedManager here so we can reference timeEntries dictionary
	MyManager *sharedManager = [MyManager sharedManager];
	
//	// Early, late, and standard lunch lists
//	// Lists contain ordered pairs: (person/row number, hour lunch state)
//	NSMutableArray *earlyLunchList;
//	NSMutableArray *standardLunchList;
//	NSMutableArray *lateLunchList;
//	
//	// Go through all staff; compile data into above lunch lists
//	for (int i = 0; i < self.nameData.count; i++) {
//		int start_num = [[sharedManager.timeEntries objectForKey:self.startTimeData[i]] intValue]; // MAX(A, B) if necessary
//		int end_num = [[sharedManager.timeEntries objectForKey:self.endTimeData[i]] intValue];
//		
//		// Only needs a lunch if on duty for 5 or more hours (10 half hours) or more
//		if (end_num - start_num >= 10) {
//			NSNumber *cell_Data = self.lunchData[i];
//			int early_lunch_state = 1 & [cell_Data integerValue];
//			int late_lunch_state = 2 & [cell_Data integerValue];
//			int hour_lunch_state = 4 & [cell_Data integerValue];
//			if (early_lunch_state) {
//				[earlyLunchList addObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:i], [NSNumber numberWithInt:hour_lunch_state], nil]];
//			}
//			else if (late_lunch_state) {
//				[lateLunchList addObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:i], [NSNumber numberWithInt:hour_lunch_state], nil]];
//			}
//			else {
//				[standardLunchList addObject:[NSMutableArray arrayWithObjects:[NSNumber numberWithInt:i], [NSNumber numberWithInt:hour_lunch_state], nil]];
//			}
//		}
//	}
//	
//	// Assign early lunches from earlyLunchList
//	for (int j = 0; j < earlyLunchList.count; j++) {
//		NSNumber *person = earlyLunchList[j][0];
//		NSNumber *hour_lunch_state = earlyLunchList[j][1];
//		if (hour_lunch_state) {
//			// Person (row variable) wants early hour lunch
//			int row = [person intValue];
//		}
//		else {
//			// Person (row variable) wants early half-hour lunch
//			int row = [person intValue];
//		}
//	}
//	
//	// Assign late lunches from lateLunchList
//	for (int j = 0; j < lateLunchList.count; j++) {
//		NSNumber *person = lateLunchList[j][0];
//		NSNumber *hour_lunch_state = lateLunchList[j][1];
//		if (hour_lunch_state) {
//			// Person (row variable) wants late hour lunch
//			int row = [person intValue];
//		}
//		else {
//			// Person (row variable) wants late half-hour lunch
//			int row = [person intValue];
//		}
//	}
//	
//	// Assign rest of the lunches from standardLunchList
//	for (int j = 0; j < standardLunchList.count; j++) {
//		NSNumber *person = standardLunchList[j][0];
//		NSNumber *hour_lunch_state = standardLunchList[j][1];
//		if (hour_lunch_state) {
//			// Person (row variable) wants hour lunch
//			int row = [person intValue];
//		}
//		else {
//			// Person (row variable) wants half-hour lunch!!!!!!!!!!!!!!!!!!!!!!!!!
//			int row = [person intValue];
//		}
//	}
//	
//	return;
	
}

// When "Save" button is pressed on AddEditStaffViewController
- (void)save:(NSString *)name withQualifications:(NSMutableArray *)qualifications {
	
	// Add name and qualifications (parameters) to staff arrays
	[self.staffNames addObject:name];
	[self.staffQualifications addObject:qualifications];
	
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

// Does the calculations needed to actually make the schedule; data already collected
- (void)makeSchedule {
		
	// Take rows out of ScheduleViewController table that have no name in the name column
	NSMutableIndexSet *indexes = [[NSMutableIndexSet alloc] init];
	for (int i = 0; i < self.nameData.count; i++) {
		if ([self.nameData[i] isEqualToString:@""]) {
			[indexes addIndex:i];
		}
	}
	[self.nameData removeObjectsAtIndexes:indexes];
	[self.startTimeData removeObjectsAtIndexes:indexes];
	[self.endTimeData removeObjectsAtIndexes:indexes];
	[self.specificStationsData removeObjectsAtIndexes:indexes];
	[self.lunchData removeObjectsAtIndexes:indexes];
	
	// If make schedule has been pressed before, there is an old array that must be cleared
	[self.schedule removeAllObjects];
	
	// Note: self.nameData.count is now the number of employees
	// So we can set the dimensions of schedule array
	for (int i = 0; i < self.nameData.count; i++) {
		[self.schedule addObject:[NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil]];
	}
	
	// Error checking:
	//   (1) start time < end time for each shift
	//   (2) start time < end time for each specific station entry
	//   (3) specific station times are subsets of shift times
	//   (4) specific station times do not conflict
	// Will show alert if there is an error
	// If any of the above error checks have caught errors, do not make schedule (i.e. end here)
	int result1 = [ErrorChecking checkShiftTimesFor:self.startTimeData until:self.endTimeData];
	int result2 = [ErrorChecking checkSpecificStationTimesFor:self.specificStationsData];
	int result3 = [ErrorChecking checkShiftTimesAndSpecificiStationTimesFor:self.startTimeData until:self.endTimeData including:self.specificStationsData];
	int result4 = [ErrorChecking checkSpecificStationTimesConflictsFor:self.specificStationsData];
	if (result1 + result2 + result3 + result4 != 0) {
		return;
	}
	
	// Set up hours/half hours on schedule using self.halfHourData
	[self setHalfHours];
	
	// X out hours that are outside a staff member's shift using self.startTimeData and self.endTimeData
	[self blockOutNonShiftHours];
	
	// Assign specific stations on schedule using self.specificStationsData
	[self assignSpecificStations];
	
	// Assign lunches on schedule using self.lunchData, self.stackLunchesData (and self.endTimeData - self.startTimeData > 5.5 check)
	[self assignLunches];
	
	// DEBUGGING
	[Printing printSchedule:self.schedule withNames:self.nameData];
	
}

@end