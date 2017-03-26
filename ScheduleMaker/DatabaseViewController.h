//
//  DatabaseViewController.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 3/11/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Model.h"

// Constants
#define ROW_HEIGHT_3 100.0;

@interface DatabaseViewController : NSViewController <NSTableViewDelegate, NSTableViewDataSource>

// Table view on database view controller
@property (strong) IBOutlet NSTableView *table;

// Reference to model that all view controllers will use
@property (strong) Model *model;

@end