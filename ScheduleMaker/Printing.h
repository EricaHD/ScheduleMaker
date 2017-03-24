//
//  Printing.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 3/23/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Printing : NSObject

// Print data entered from ScheduleViewController (mostly for debugging purposes)
+ (void)printScheduleData:(NSMutableArray *)nameData withStart:(NSMutableArray *)startTimeData withEnd:(NSMutableArray *)endTimeData withSpecifics:(NSMutableArray *)specificStationsData withLunch:(NSMutableArray *)lunchData;

// Print data entered from RequirementsViewController (mostly for debugging purposes)
+ (void)printRequirementsData:(NSMutableArray *)stationList withChecks:(NSMutableArray *)stationData withStart:(NSMutableArray *)stationStartTimeData withEnd:(NSMutableArray *)stationEndTimeData withFrequency:(NSMutableArray *)stationFrequencyData withHalfHours:(NSMutableArray *)halfHourData withStackLunches:(NSMutableArray *)stackLunchesData;

// Print schedule array, formated next to names and times for easy viewing and debugging
+ (void)printSchedule:(NSMutableArray *)schedule withNames:(NSMutableArray *)nameData;

@end