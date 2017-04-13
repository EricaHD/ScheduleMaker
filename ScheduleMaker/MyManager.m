//
//  MyManager.m
//  ScheduleMaker
//
//  Created by Erica Dominic on 3/23/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import "MyManager.h"

@implementation MyManager

// Initializes a static variable called sharedMyManager (initialized only once)
+ (id)sharedManager {
	
	static MyManager *sharedMyManager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{sharedMyManager = [[self alloc] init];});
	return sharedMyManager;
	
}

// Set value of properties listed in MyManager.h (i.e. timeEntries dictionary)
- (id)init {
	
	if (self = [super init]) {
		self.timeEntries = @{@"8:00 am" : [NSNumber numberWithInt:-4], @"8:30 am" : [NSNumber numberWithInt:-3], @"9:00 am" : [NSNumber numberWithInt:-2], @"9:30 am" : [NSNumber numberWithInt:-1], @"10:00 am" : [NSNumber numberWithInt:0], @"10:30 am" : [NSNumber numberWithInt:1], @"11:00 am" : [NSNumber numberWithInt:2], @"11:30 am" : [NSNumber numberWithInt:3], @"12:00 pm" : [NSNumber numberWithInt:4], @"12:30 pm" : [NSNumber numberWithInt:5], @"1:00 pm" : [NSNumber numberWithInt:6], @"1:30 pm" : [NSNumber numberWithInt:7], @"2:00 pm" : [NSNumber numberWithInt:8], @"2:30 pm" : [NSNumber numberWithInt:9], @"3:00 pm" : [NSNumber numberWithInt:10], @"3:30 pm" : [NSNumber numberWithInt:11], @"4:00 pm" : [NSNumber numberWithInt:12], @"4:30 pm" : [NSNumber numberWithInt:13], @"5:00 pm" : [NSNumber numberWithInt:14]};
		self.frequencyEntries = @{@"With schedule" : [NSNumber numberWithInt:0], @"Every half hour" : [NSNumber numberWithInt:1], @"Every hour" : [NSNumber numberWithInt:2], @"One person" : [NSNumber numberWithInt:3]};
	}
	
	return self;
}

@end