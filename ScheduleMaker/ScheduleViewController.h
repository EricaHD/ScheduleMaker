//
//  ScheduleViewController.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 12/26/16.
//  Copyright © 2016 Erica Dominic. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Model.h"

@interface ScheduleViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource, NSTextFieldDelegate>

// Table view on schedule view controller
@property (strong) IBOutlet NSTableView *table;

// Reference to model that all view controllers will use
@property (strong) Model *model;

// Array used to hold suggestions for autocomplete text field
@property (strong) NSMutableArray *autocompleteOptions;

@end