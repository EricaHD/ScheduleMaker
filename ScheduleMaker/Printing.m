//
//  Printing.m
//  ScheduleMaker
//
//  Created by Erica Dominic on 3/23/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import "Printing.h"

@interface Printing ()

@end

@implementation Printing

// Initialize a model object
- (id)init {
	
	// Call super class init method
	self = [super init];
	
	// Return
	return self;
	
}

// Print data entered from ScheduleViewController (mostly for debugging purposes)
+ (void)printScheduleData:(NSMutableArray *)nameData withStart:(NSMutableArray *)startTimeData withEnd:(NSMutableArray *)endTimeData withSpecifics:(NSMutableArray *)specificStationsData withLunch:(NSMutableArray *)lunchData {
	
	NSLog(@"SCHEDULE");
	NSLog(@" ");
	for (int i = 0; i < nameData.count; i++) {
		if (![nameData[i] isEqualToString:@""]) {
			NSLog(@"%@: %@ - %@", nameData[i], startTimeData[i], endTimeData[i]);
			if (![specificStationsData[i][0] isEqualToString:@""]) { // is a 9-element array
				NSLog(@"     %@: %@ - %@", specificStationsData[i][0], specificStationsData[i][1], specificStationsData[i][2]);
			}
			if (![specificStationsData[i][3] isEqualToString:@""]) { // is a 9-element array
				NSLog(@"     %@: %@ - %@", specificStationsData[i][3], specificStationsData[i][4], specificStationsData[i][5]);
			}
			if (![specificStationsData[i][6] isEqualToString:@""]) { // is a 9-element array
				NSLog(@"     %@: %@ - %@", specificStationsData[i][6], specificStationsData[i][7], specificStationsData[i][8]);
			}
			NSInteger early = (1 & [lunchData[i] integerValue]) ? 1 : 0;
			if (early) {
				NSLog(@"     Early lunch");
			}
			NSInteger late = (2 & [lunchData[i] integerValue]) ? 1 : 0;
			if (late) {
				NSLog(@"     Late lunch");
			}
			NSInteger hour = (4 & [lunchData[i] integerValue]) ? 1 : 0;
			if (hour) {
				NSLog(@"     Hour lunch");
			}
		}
	}
	
	NSLog(@" ");
	
}

// Print data entered from RequirementsViewController (mostly for debugging purposes)
+ (void)printRequirementsData:(NSMutableArray *)stationList withChecks:(NSMutableArray *)stationData withStart:(NSMutableArray *)stationStartTimeData withEnd:(NSMutableArray *)stationEndTimeData withFrequency:(NSMutableArray *)stationFrequencyData withHalfHours:(NSMutableArray *)halfHourData withStackLunches:(NSMutableArray *)stackLunchesData {
	
	NSLog(@"REQUIREMENTS");
	NSLog(@" ");
	for (int i = 0; i < stationList.count; i++) {
		if ([stationData[i] intValue]) {
			NSLog(@"%@: %@ - %@", stationList[i], stationStartTimeData[i], stationEndTimeData[i]);
			NSLog(@"     with frequency '%@'", stationFrequencyData[i]);
		}
	}
	
	NSLog(@" ");
	
	NSLog(@"Half hours checked:");
	if ([halfHourData[0] intValue]) {
		NSLog(@"     10 am");
	}
	if ([halfHourData[1] intValue]) {
		NSLog(@"     11 am");
	}
	if ([halfHourData[2] intValue]) {
		NSLog(@"     12 pm");
	}
	if ([halfHourData[3] intValue]) {
		NSLog(@"     1 pm");
	}
	if ([halfHourData[4] intValue]) {
		NSLog(@"     2 pm");
	}
	if ([halfHourData[5] intValue]) {
		NSLog(@"     3 pm");
	}
	if ([halfHourData[6] intValue]) {
		NSLog(@"     4 pm");
	}
	NSLog(@"Stack lunches checked:");
	if ([stackLunchesData[0] intValue]) {
		NSLog(@"     11:00 am");
	}
	if ([stackLunchesData[1] intValue]) {
		NSLog(@"     11:30 am");
	}
	if ([stackLunchesData[2] intValue]) {
		NSLog(@"     12:00 pm");
	}
	if ([stackLunchesData[3] intValue]) {
		NSLog(@"     12:30 pm");
	}
	if ([stackLunchesData[4] intValue]) {
		NSLog(@"     1:00 pm");
	}
	if ([stackLunchesData[5] intValue]) {
		NSLog(@"     1:30 pm");
	}
	
	NSLog(@" ");
	
}

// Print schedule array, formated next to names and times for easy viewing and debugging
+ (void)printSchedule:(NSMutableArray *)schedule withNames:(NSMutableArray *)nameData {

	// Print contents of schedule
	NSLog(@"%@", [NSString stringWithFormat:@"%-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %s", [@"" UTF8String], [@"10:00 am" UTF8String], [@"10:30 am" UTF8String], [@"11:00 am" UTF8String], [@"11:30 am" UTF8String], [@"12:00 pm" UTF8String], [@"12:30 pm" UTF8String], [@"1:00 pm" UTF8String], [@"1:30 pm" UTF8String], [@"2:00 pm" UTF8String], [@"2:30 pm" UTF8String], [@"3:00 pm" UTF8String], [@"3:30 pm" UTF8String], [@"4:00 pm" UTF8String], [@"4:30 pm" UTF8String]]);
	for (int i = 0; i < nameData.count; i++) {
		NSLog(@"%@", [NSString stringWithFormat:@"%-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s %s", [nameData[i] UTF8String], [schedule[i][0] UTF8String], [schedule[i][1] UTF8String], [schedule[i][2] UTF8String], [schedule[i][3] UTF8String], [schedule[i][4] UTF8String], [schedule[i][5] UTF8String], [schedule[i][6] UTF8String], [schedule[i][7] UTF8String], [schedule[i][8] UTF8String], [schedule[i][9] UTF8String], [schedule[i][10] UTF8String], [schedule[i][11] UTF8String], [schedule[i][12] UTF8String], [schedule[i][13] UTF8String]]);
	}
	
	return;
	
}

@end