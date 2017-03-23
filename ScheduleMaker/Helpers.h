//
//  Helpers.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 3/22/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helpers : NSObject

// Show alert with specified message
+ (void)showAlert:(NSString *)title withDetails:(NSString *)details;

// Check that end time comes after the start time for each shift; shows alert if this is not the case
+ (int)checkShiftTimesFor:(NSMutableArray *)startTimeData until:(NSMutableArray *)endTimeData;

// Check that end time comes after the start time for each specific station entry; shows alert if this is not the case
+ (int)checkSpecificStationTimesFor:(NSMutableArray *)specificStationsData;

// Check that specific station times are subsets of shift times; will show alert if there is an error
+ (int)checkShiftTimesAndSpecificiStationTimesFor:(NSMutableArray *)startTimeData until:(NSMutableArray *)endTimeData including:(NSMutableArray *)specificStationsData;

// Check that specific station times do not conflict; will show alert if there is an error
+ (int)checkSpecificStationTimesConflictsFor:(NSMutableArray *)specificStationsData;

@end