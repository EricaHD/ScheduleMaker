//
//  MayBePlacedTableCellView.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 2/6/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MayBePlacedTableCellView : NSTableCellView

// The state of these nine checkboxes can be embodied in a single integer as follows
// As usual, NSOffState = 0 and NSOnState = 1
// Single integer = birthday's state * 1
//                  + gallery's state * 2
//                  + greeting's state * 4
//                  + lesson's state * 8
//                  + manager's state * 16
//                  + other's state * 32
//                  + project's state * 64
//                  + security's state * 128
//                  + tours' state * 256
// So, for example, if only gallery, project, and tours checkboxes are selected,
// the single descriptive integer in binary is 101000010, which is 2+64+256 = 322 in decimal
// Given a descriptive integer N formatted this way, it is easy to test if the lesson checkbox
// in that cell is selected with bitwise operations: N & 000001000

@property (strong) IBOutlet NSButton *birthday;
@property (strong) IBOutlet NSButton *gallery;
@property (strong) IBOutlet NSButton *greeting;
@property (strong) IBOutlet NSButton *lesson;
@property (strong) IBOutlet NSButton *manager;
@property (strong) IBOutlet NSButton *other;
@property (strong) IBOutlet NSButton *project;
@property (strong) IBOutlet NSButton *security;
@property (strong) IBOutlet NSButton *tours;

@end