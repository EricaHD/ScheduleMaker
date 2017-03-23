//
//  Model.m
//  ScheduleMaker
//
//  Created by Erica Dominic on 2/9/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import "Model.h"
#import "Helpers.h"

@interface Model ()

@property (strong) NSDictionary *timeEntries;
@property (strong) NSMutableArray *schedule;

@end

@implementation Model

// Initialize a model object
- (id)init {
	
	// Call super class init method
	self = [super init];
	
	// Initialize instance variables
	self.schedule = [NSMutableArray array];
	self.timeEntries = @{@"10:00 am" : [NSNumber numberWithInt:0], @"10:30 am" : [NSNumber numberWithInt:1], @"11:00 am" : [NSNumber numberWithInt:2], @"11:30 am" : [NSNumber numberWithInt:3], @"12:00 pm" : [NSNumber numberWithInt:4], @"12:30 pm" : [NSNumber numberWithInt:5], @"1:00 pm" : [NSNumber numberWithInt:6], @"1:30 pm" : [NSNumber numberWithInt:7], @"2:00 pm" : [NSNumber numberWithInt:8], @"2:30 pm" : [NSNumber numberWithInt:9], @"3:00 pm" : [NSNumber numberWithInt:10], @"3:30 pm" : [NSNumber numberWithInt:11], @"4:00 pm" : [NSNumber numberWithInt:12], @"4:30 pm" : [NSNumber numberWithInt:13], @"5:00 pm" : [NSNumber numberWithInt:14]};
	
	// Return
	return self;
	
}

////////////////////////////////////////////////////////////////////////////////
// HELPER METHODS USED WHILE MAKING SCHEDULE ///////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//// Set up hours/half hours on schedule
//- (void)setHalfHours:(NSMutableArray *)halfHourData {
//	
//	for (int i = 0; i < halfHourData.count; i++) {
//		if (![halfHourData[i] intValue]) {
//			// 2i + 1 should say "SAME"
//			for (int j = 0; j < self.schedule.count; j++) {
//				self.schedule[j][2*i+1] = @"SAME";
//			}
//		}
//	}
//	
//	return;
//}
//
//// X out hours that are outside a staff member's shift
//- (void)blockOutNonShiftHours:(NSMutableArray *)startTimeData until:(NSMutableArray *)endTimeData {
//	
//	for (int i = 0; i < self.nameData.count; i++) {
//		double start_num = [[self.timeEntries objectForKey:startTimeData[i]] doubleValue];
//		double end_num = [[self.timeEntries objectForKey:endTimeData[i]] doubleValue];
//		for (int j = 0; j < start_num; j++) {
//			self.schedule[i][j] = @"X";
//		}
//		int next = start_num;
//		// If we have "X" then "SAME" delete the "SAME" so "X" doesn't extend further than necessary
//		if (next < 14 && [self.schedule[i][next] isEqualToString:@"SAME"]) {
//			self.schedule[i][next] = @"";
//		}
//		for (int k = end_num; k < 14; k++) {
//			self.schedule[i][k] = @"X";
//		}
//	}
//	
//	return;
//	
//}
//
//// Assign specific stations on schedule
//- (void)assignSpecificStations:(NSMutableArray *)specificStationsData {
//
//	for (int i = 0; i < self.nameData.count; i++) {
//		
//		// Prepare for and get specpfic stations cell information
//		int start_num;
//		int end_num;
//		NSMutableArray *cell_data = specificStationsData[i];
//
//		// Insert specific station #1 into schedule
//		if (![cell_data[0] isEqualToString:@""]) {
//			start_num = [[self.timeEntries objectForKey:cell_data[1]] intValue];
//			end_num = [[self.timeEntries objectForKey:cell_data[2]] intValue];
//			for (int j = start_num; j < end_num; j++) {
//				self.schedule[i][j] = cell_data[0];
//			}
//		}
//		if (end_num < 14 && [self.schedule[i][end_num] isEqualToString:@"SAME"]) {
//			self.schedule[i][end_num] = @"";
//		}
//		
//		// Insert specific station #2 into schedule
//		if (![cell_data[3] isEqualToString:@""]) {
//			start_num = [[self.timeEntries objectForKey:cell_data[4]] intValue];
//			end_num = [[self.timeEntries objectForKey:cell_data[5]] intValue];
//			for (int j = start_num; j < end_num; j++) {
//				self.schedule[i][j] = cell_data[3];
//			}
//		}
//		if (end_num < 14 && [self.schedule[i][end_num] isEqualToString:@"SAME"]) {
//			self.schedule[i][end_num] = @"";
//		}
//		
//
//		// Insert specific station #2 into schedule
//		if (![cell_data[6] isEqualToString:@""]) {
//			start_num = [[self.timeEntries objectForKey:cell_data[7]] intValue];
//			end_num = [[self.timeEntries objectForKey:cell_data[8]] intValue];
//			for (int j = start_num; j < end_num; j++) {
//				self.schedule[i][j] = cell_data[6];
//			}
//		}
//		if (end_num < 14 && [self.schedule[i][end_num] isEqualToString:@"SAME"]) {
//			self.schedule[i][end_num] = @"";
//		}
//
//	}
//	
//	return;
//	
//}
//
//// Assign lunches on schedule for staff members at the museum for > 5 hours
//- (void)assignLunches:(NSMutableArray *)lunchData starting:(NSMutableArray *)startTimeData ending:(NSMutableArray *)endTimeData {
//	
//	// Early, late, and standard lunch lists
//	// Lists contain ordered pairs: (person/row number, hour lunch state)
//	NSMutableArray *earlyLunchList;
//	NSMutableArray *standardLunchList;
//	NSMutableArray *lateLunchList;
//	
//	// Go through all staff; compile data into above lunch lists
//	for (int i = 0; i < self.nameData.count; i++) {
//		int start_num = [[self.timeEntries objectForKey:startTimeData[i]] intValue];
//		int end_num = [[self.timeEntries objectForKey:endTimeData[i]] intValue];
//		
//		// Only needs a lunch if on duty for 5 or more hours (10 half hours) or more
//		if (end_num - start_num >= 10) {
//			NSNumber *cell_Data = lunchData[i];
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
//			// TODO: person (row variable) wants early hour lunch
//			int row = [person intValue];
//			(void) row; // TODO
//		}
//		else {
//			// TODO: person (row variable) wants early half-hour lunch
//			int row = [person intValue];
//			(void) row; // TODO
//		}
//	}
//	
//	// Assign late lunches from lateLunchList
//	for (int j = 0; j < lateLunchList.count; j++) {
//		NSNumber *person = lateLunchList[j][0];
//		NSNumber *hour_lunch_state = lateLunchList[j][1];
//		if (hour_lunch_state) {
//			// TODO: person (row variable) wants late hour lunch
//			int row = [person intValue];
//			(void) row; // TODO
//		}
//		else {
//			// TODO: person (row variable) wants late half-hour lunch
//			int row = [person intValue];
//			(void) row; // TODO
//		}
//	}
//	
//	// Assign rest of the lunches from standardLunchList
//	for (int j = 0; j < standardLunchList.count; j++) {
//		NSNumber *person = standardLunchList[j][0];
//		NSNumber *hour_lunch_state = standardLunchList[j][1];
//		if (hour_lunch_state) {
//			// TODO: person (row variable) wants hour lunch
//			int row = [person intValue];
//			(void) row; // TODO
//		}
//		else {
//			// TODO: person (row variable) wants half-hour lunch!!!!!!!!!!!!!!!!!!!!!!!!!
//			int row = [person intValue];
//			(void) row; // TODO
//		}
//	}
//	
//	return;
//	
//}

////////////////////////////////////////////////////////////////////////////////
// PUBLIC METHODS; CORRESPOND TO BUTTONS ON SCHEDULE VIEW CONTROLLER ///////////
////////////////////////////////////////////////////////////////////////////////

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
	
	// USE ONLY VALID ROWS IN SCHEDULE VIEW CONTROLLER TABLE ///////////////////
	
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
	
	// Note: self.nameData.count is now the number of employees
	// So we can set the dimensions of schedule array
	for (int i = 0; i < self.nameData.count; i++) {
		[self.schedule addObject:[NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", nil]];
	}
	
	// ERROR CHECKING //////////////////////////////////////////////////////////
	
	// Ensure start time < end time for each shift; will show alert if there is an error
	int result1 = [Helpers checkShiftTimesFor:self.startTimeData until:self.endTimeData];
	
	// Error checking: ensure start time < end time for each specific station entry; will show alert if there is an error
	int result2 = [Helpers checkSpecificStationTimesFor:self.specificStationsData];
	
	// Error checking: ensure specific station times are subsets of shift times; will show alert if there is an error
	int result3 = [Helpers checkShiftTimesAndSpecificiStationTimesFor:self.startTimeData until:self.endTimeData including:self.specificStationsData];
	
	// Error checking: ensure specific station times do not conflict; will show alert if there is an error
	int result4 = [Helpers checkSpecificStationTimesConflictsFor:self.specificStationsData];
	
	// If any of the above error checks have caught errors, do not make schedule (i.e. end here)
	if (result1 + result2 + result3 + result4 != 0) {
		return;
	}
	
	// SET UP HOURS AND HALF HOURS ON SCHEDULE /////////////////////////////////
	
	// Set up hours/half hours on schedule
	//	NSMutableArray *halfHourData = [NSMutableArray arrayWithObjects:[NSNumber numberWithLong:tenAM.state], [NSNumber numberWithLong:elevenAM.state], [NSNumber numberWithLong:twelvePM.state], [NSNumber numberWithLong:onePM.state], [NSNumber numberWithLong:twoPM.state], [NSNumber numberWithLong:threePM.state], [NSNumber numberWithLong:fourPM.state], nil];
	//	[model setHalfHours:halfHourData];
	
	// MAKE NECESSARY ASSIGNMENTS //////////////////////////////////////////////
	
	// X out hours that are outside a staff member's shift
	//	[model blockOutNonShiftHours:startTimeData until:endTimeData];
	
	// Assign specific stations on schedule
	//	[model assignSpecificStations:specificStationsData];
	
	// MAKE INTELLIGENT ASSIGNMENTS ////////////////////////////////////////////
	
	// Assign lunches on schedule
	//	[model assignLunches:lunchData starting:startTimeData ending:endTimeData];
	
}

////////////////////////////////////////////////////////////////////////////////
// PRINTING INFO FOR DEBUGGING /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// Print data entered from ScheduleViewController (mostly for debugging purposes)
- (void)printScheduleData {
	
	NSLog(@"SCHEDULE");
	NSLog(@" ");
	for (int i = 0; i < self.nameData.count; i++) {
		if (![self.nameData[i] isEqualToString:@""]) {
			NSLog(@"%@: %@ - %@", self.nameData[i], self.startTimeData[i], self.endTimeData[i]);
			if (![self.specificStationsData[i][0] isEqualToString:@""]) { // is a 9-element array
				NSLog(@"     %@: %@ - %@", self.specificStationsData[i][0], self.specificStationsData[i][1], self.specificStationsData[i][2]);
			}
			if (![self.specificStationsData[i][3] isEqualToString:@""]) { // is a 9-element array
				NSLog(@"     %@: %@ - %@", self.specificStationsData[i][3], self.specificStationsData[i][4], self.specificStationsData[i][5]);
			}
			if (![self.specificStationsData[i][6] isEqualToString:@""]) { // is a 9-element array
				NSLog(@"     %@: %@ - %@", self.specificStationsData[i][6], self.specificStationsData[i][7], self.specificStationsData[i][8]);
			}
			NSInteger early = (1 & [self.lunchData[i] integerValue]) ? 1 : 0;
			if (early) {
				NSLog(@"     Early lunch");
			}
			NSInteger late = (2 & [self.lunchData[i] integerValue]) ? 1 : 0;
			if (late) {
				NSLog(@"     Late lunch");
			}
			NSInteger hour = (4 & [self.lunchData[i] integerValue]) ? 1 : 0;
			if (hour) {
				NSLog(@"     Hour lunch");
			}
		}
	}
	
	NSLog(@" ");
	
}

// Print data entered from RequirementsViewController (mostly for debugging purposes)
- (void)printRequirementsData {
	
	NSLog(@"REQUIREMENTS");
	NSLog(@" ");
	for (int i = 0; i < self.stationList.count; i++) {
		if ([self.stationData[i] intValue]) {
			NSLog(@"%@: %@ - %@", self.stationList[i], self.stationStartTimeData[i], self.stationEndTimeData[i]);
			NSLog(@"     with frequency '%@'", self.stationFrequencyData[i]);
		}
	}
	
	NSLog(@" ");
	
	NSLog(@"Half hours checked:");
	if ([self.halfHourData[0] intValue]) {
		NSLog(@"     10 am");
	}
	if ([self.halfHourData[1] intValue]) {
		NSLog(@"     11 am");
	}
	if ([self.halfHourData[2] intValue]) {
		NSLog(@"     12 pm");
	}
	if ([self.halfHourData[3] intValue]) {
		NSLog(@"     1 pm");
	}
	if ([self.halfHourData[4] intValue]) {
		NSLog(@"     2 pm");
	}
	if ([self.halfHourData[5] intValue]) {
		NSLog(@"     3 pm");
	}
	if ([self.halfHourData[6] intValue]) {
		NSLog(@"     4 pm");
	}
	NSLog(@"Stack lunches checked:");
	if ([self.stackLunchesData[0] intValue]) {
		NSLog(@"     11:00 am");
	}
	if ([self.stackLunchesData[1] intValue]) {
		NSLog(@"     11:30 am");
	}
	if ([self.stackLunchesData[2] intValue]) {
		NSLog(@"     12:00 pm");
	}
	if ([self.stackLunchesData[3] intValue]) {
		NSLog(@"     12:30 pm");
	}
	if ([self.stackLunchesData[4] intValue]) {
		NSLog(@"     1:00 pm");
	}
	if ([self.stackLunchesData[5] intValue]) {
		NSLog(@"     1:30 pm");
	}

	NSLog(@" ");
	
}

// Print schedule array, formated next to names and times for easy viewing and debugging
- (void)printSchedule {
	
	// Print contents of schedule
	NSLog(@"%@", [NSString stringWithFormat:@"%-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %s", [@"" UTF8String], [@"10:00 am" UTF8String], [@"10:30 am" UTF8String], [@"11:00 am" UTF8String], [@"11:30 am" UTF8String], [@"12:00 pm" UTF8String], [@"12:30 pm" UTF8String], [@"1:00 pm" UTF8String], [@"1:30 pm" UTF8String], [@"2:00 pm" UTF8String], [@"2:30 pm" UTF8String], [@"3:00 pm" UTF8String], [@"3:30 pm" UTF8String], [@"4:00 pm" UTF8String], [@"4:30 pm" UTF8String]]);
	for (int i = 0; i < self.nameData.count; i++) {
		NSLog(@"%@", [NSString stringWithFormat:@"%-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %s", [self.nameData[i] UTF8String], [self.schedule[i][0] UTF8String], [self.schedule[i][1] UTF8String], [self.schedule[i][2] UTF8String], [self.schedule[i][3] UTF8String], [self.schedule[i][4] UTF8String], [self.schedule[i][5] UTF8String], [self.schedule[i][6] UTF8String], [self.schedule[i][7] UTF8String], [self.schedule[i][8] UTF8String], [self.schedule[i][9] UTF8String], [self.schedule[i][10] UTF8String], [self.schedule[i][11] UTF8String], [self.schedule[i][12] UTF8String], [self.schedule[i][13] UTF8String]]);
	}
	
	return;
	
}

@end