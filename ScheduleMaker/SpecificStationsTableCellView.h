//
//  SpecificStationsTableCellView.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 2/7/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SpecificStationsTableCellView : NSTableCellView

@property (strong) IBOutlet NSTextField *specific1;
@property (strong) IBOutlet NSPopUpButton *specific1_starttime;
@property (strong) IBOutlet NSPopUpButton *specific1_endtime;
@property (strong) IBOutlet NSTextField *specific2;
@property (strong) IBOutlet NSPopUpButton *specific2_starttime;
@property (strong) IBOutlet NSPopUpButton *specific2_endtime;
@property (strong) IBOutlet NSTextField *specific3;
@property (strong) IBOutlet NSPopUpButton *specific3_starttime;
@property (strong) IBOutlet NSPopUpButton *specific3_endtime;

@end