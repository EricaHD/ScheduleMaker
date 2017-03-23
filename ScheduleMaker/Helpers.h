//
//  Helpers.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 3/22/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helpers : NSObject

+ (void)showAlert:(NSString *)title withDetails:(NSString *)details;
+ (void)checkShiftTimesFor:(NSMutableArray *)startTimeData until:(NSMutableArray *)endTimeData;

@end