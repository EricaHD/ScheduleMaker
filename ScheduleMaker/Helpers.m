//
//  Helpers.m
//  ScheduleMaker
//
//  Created by Erica Dominic on 3/22/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Helpers.h"

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
	
	NSDictionary *timeEntries = @{@"10:00 am" : [NSNumber numberWithInt:0], @"10:30 am" : [NSNumber numberWithInt:1], @"11:00 am" : [NSNumber numberWithInt:2], @"11:30 am" : [NSNumber numberWithInt:3], @"12:00 pm" : [NSNumber numberWithInt:4], @"12:30 pm" : [NSNumber numberWithInt:5], @"1:00 pm" : [NSNumber numberWithInt:6], @"1:30 pm" : [NSNumber numberWithInt:7], @"2:00 pm" : [NSNumber numberWithInt:8], @"2:30 pm" : [NSNumber numberWithInt:9], @"3:00 pm" : [NSNumber numberWithInt:10], @"3:30 pm" : [NSNumber numberWithInt:11], @"4:00 pm" : [NSNumber numberWithInt:12], @"4:30 pm" : [NSNumber numberWithInt:13], @"5:00 pm" : [NSNumber numberWithInt:14]};
	
	// Check each start time >= end time
	for (int i = 0; i < startTimeData.count; i++) {
		int start_num = [[timeEntries objectForKey:startTimeData[i]] intValue];
		int end_num = [[timeEntries objectForKey:endTimeData[i]] intValue];
		if (start_num >= end_num) {
			[self showAlert:@"Invalid shift times" withDetails:[NSString stringWithFormat:@"Please check shift times in row #%d.", i+1]];
		}
	}

}

@end