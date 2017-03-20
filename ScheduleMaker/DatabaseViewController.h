//
//  DatabaseViewController.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 3/11/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Model.h"

@interface DatabaseViewController : NSViewController

// Reference to model that all view controllers will use
@property (strong) Model *model;

@end