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
	
}

- (int)countNumStaff:(NSMutableArray *)names;
- (int)checkShiftTimesFor:(int)n starts:(NSMutableArray *)startTimeData ends:(NSMutableArray *)endTimeData;

@end