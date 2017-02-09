//
//  LunchTableCellView.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 2/8/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LunchTableCellView : NSTableCellView

@property (strong) IBOutlet NSButton *early_lunch;
@property (strong) IBOutlet NSButton *late_lunch;
@property (strong) IBOutlet NSButton *hour_lunch;

@end