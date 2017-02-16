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
	
}

- (void)setNumStaff:(NSMutableArray *)names;
- (int)getNumStaff;
- (int)checkShiftTimesFor:(NSMutableArray *)startTimeData until:(NSMutableArray *)endTimeData;
- (int)checkSpecialStationTimesFor:(NSMutableArray *)specificStationsData;
- (void)blockOutNonShiftHours:(NSMutableArray *)startTimeData until:(NSMutableArray *)endTimeData;
- (void)printSchedule:(NSMutableArray *)nameData;

@end