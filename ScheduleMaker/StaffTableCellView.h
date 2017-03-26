//
//  StaffTableCellView.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 3/24/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface StaffTableCellView : NSTableCellView

@property (strong) IBOutlet NSTextField *name;
@property (strong) IBOutlet NSButton *trike;
@property (strong) IBOutlet NSButton *coro;
@property (strong) IBOutlet NSButton *negOne;
@property (strong) IBOutlet NSButton *zero;
@property (strong) IBOutlet NSButton *gallery;
@property (strong) IBOutlet NSButton *floating;
@property (strong) IBOutlet NSButton *project;
@property (strong) IBOutlet NSButton *greeting;
@property (strong) IBOutlet NSButton *security;
@property (strong) IBOutlet NSButton *tours;
@property (strong) IBOutlet NSButton *lesson;
@property (strong) IBOutlet NSButton *manager;
@property (strong) IBOutlet NSButton *birthday;
@property (strong) IBOutlet NSButton *other;
@property (strong) IBOutlet NSButton *fireguard;

@end