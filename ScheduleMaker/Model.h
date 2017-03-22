//
//  Model.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 2/9/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

// Arrays for ScheduleViewController table
@property (strong) NSMutableArray *nameData;
@property (strong) NSMutableArray *startTimeData;
@property (strong) NSMutableArray *endTimeData;
@property (strong) NSMutableArray *specificStationsData;
@property (strong) NSMutableArray *lunchData;

// Arrays for RequirementsViewController table
@property (strong) NSMutableArray *stationList;
@property (strong) NSMutableArray *stationData;
@property (strong) NSMutableArray *stationStartTimeData;
@property (strong) NSMutableArray *stationEndTimeData;
@property (strong) NSMutableArray *stationFrequencyData;

// Arrays for side checkbo buttons in RequirementsViewController
@property (strong) NSMutableArray *halfHourData;
@property (strong) NSMutableArray *stackLunchesData;

// Print schedule (mostly for debugging purposes)
- (void)printSchedule:(NSMutableArray *)nameData;

@end