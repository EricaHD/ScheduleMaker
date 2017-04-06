//
//  AutocompleteTableCellView.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 4/5/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AutocompleteTableCellView : NSTableCellView

@property (strong) IBOutlet NSTextField *option;
@property (strong) IBOutlet NSTextField *option1;
@property (strong) IBOutlet NSTextField *option2;
@property (strong) IBOutlet NSTextField *option3;

@end