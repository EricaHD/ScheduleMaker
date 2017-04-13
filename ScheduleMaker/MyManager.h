//
//  MyManager.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 3/23/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyManager : NSObject

// Time entries dictionary that we will use to translate time dropdown menu selection titles into values
@property (nonatomic, retain) NSDictionary *timeEntries;

// Shift change frequency dictionary that we will use to translate frequency dropdown menu selection titles into values
@property (nonatomic, retain) NSDictionary *frequencyEntries;

// Initializes a static variable called sharedMyManager (initialized only once)
+ (id)sharedManager;

@end