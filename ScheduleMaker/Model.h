//
//  Model.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 2/9/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject {
	
	int x;
	
}

- (void)setX:(int)value;
- (int)getX;
- (void)checkShiftDuration:(NSMutableArray *)starttimes until:(NSMutableArray *)endtimes;

@end