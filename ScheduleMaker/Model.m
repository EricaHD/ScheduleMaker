//
//  Model.m
//  ScheduleMaker
//
//  Created by Erica Dominic on 2/9/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import "Model.h"

@implementation Model

-(void)setX:(int)value {
	
	x = value;
	
}

-(int)getX {
	
	return x;
	
}

- (void)checkShiftDuration:(NSMutableArray *)starttimes until:(NSMutableArray *)endtimes {
	
	assert(starttimes.count == endtimes.count); // TODO
	
	for (int i = 0; i < starttimes.count; i++) {
		// assert starttime[i] < endtime[i]
	}
	
}

@end