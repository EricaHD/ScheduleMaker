//
//  Model.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 2/9/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject {

	NSDictionary *timeEntries;
	int numStaff;
	NSMutableArray *schedule;
	NSInteger lunchCount[14];
	
}

@property (strong) NSString *str; // TESTING

// Arrays for ScheduleViewController
@property (strong) NSMutableArray *nameData;
@property (strong) NSMutableArray *startTimeData;
@property (strong) NSMutableArray *endTimeData;
@property (strong) NSMutableArray *specificStationsData;
@property (strong) NSMutableArray *lunchData;

- (void)setNumStaff:(NSMutableArray *)names;
- (int)getNumStaff;

- (int)checkShiftTimesFor:(NSMutableArray *)startTimeData until:(NSMutableArray *)endTimeData;
- (int)checkSpecificStationTimesFor:(NSMutableArray *)specificStationsData;
- (int)checkShiftTimesAndSpecificiStationTimesFor:(NSMutableArray *)startTimeData until:(NSMutableArray *)endTimeData including:(NSMutableArray *)specificStationsData;
- (int)checkSpecificStationTimesConflictsFor:(NSMutableArray *)specificStationsData;

- (void)setHalfHours:(NSMutableArray *)halfHourData;
- (void)blockOutNonShiftHours:(NSMutableArray *)startTimeData until:(NSMutableArray *)endTimeData;
- (void)assignSpecificStations:(NSMutableArray *)specificStationsData;
- (void)assignLunches:(NSMutableArray *)lunchData starting:(NSMutableArray *)startTimeData ending:(NSMutableArray *)endTimeData;

- (void)printSchedule:(NSMutableArray *)nameData;

@end