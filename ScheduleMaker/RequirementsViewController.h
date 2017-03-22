//
//  RequirementsViewController.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 3/11/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Model.h"

// Constants
#define ROW_HEIGHT_2 25.0;

@interface RequirementsViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>

// Table view on requirements view controller
@property (strong) IBOutlet NSTableView *table;

// Reference to model that all view controllers will use
@property (strong) Model *model;

// Update the checkboxes on the right side of the view controller to reflect array entries
- (void)reloadHalfHourData;
- (void)reloadStackLunchesData;

@end