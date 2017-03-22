//
//  AppDelegate.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 12/26/16.
//  Copyright © 2016 Erica Dominic. All rights reserved.
//

// TO DO NEXT:
// Pass data back to Model (for RequirementsViewController, do it when we change tabs away from that view, and for ScheduleViewController, when "Make schedule" is pressed...see scrapeData method)
// Move the big commented out chunk of code at the end of ScheduleViewController.m into Model.m, but neaten up Model.m while you're at it
// Lay out Database view controller
// Add autocomplete from database feature in Schedule view controller (for names and specific stations)
// Make special stations customizable with +/- buttons
// Actually do the data processing and making of the schedule
// Invoke a script that will open LibreOffice and fill in schedule as if Sook has just written it, ready for editing (if necessary) and printing as usual
// Revisit DEFAULTs and actually implement use of NSUserDefaults

// Add another "0" and "Float" to RequirementsViewController?
// Change start time menus in ScheduleViewController to include 8:00 am, 8:30 am, 9:00 am, 9:30 am.
// Go back and figure out which @property need (strong)
// Go back to TODOs
// Go back to NSLog(@"Error: ..."); and handle errors more gracefully
// Intead of doing (viewControllerArray.count == 3) check and if not a clumsy NSLog error message, figure out how to have program WAIT until that condition is true, then do the work of finding the three view controllers within AppDelegate.m

// ADDITIONS:
// 1. README/instruction booklet describing use of software
// 2. Further error checking?  Like entering only a space " " will count as a valid entry
// 3. Could adds "lunch" or "no lunch" option in case someone wants a lunch but is working <5.5 hours
// 4. Could display messages on the results, i.e. "Gallery must be closed 12-1 pm" or "Only one person stationed on floor -1 during 11-5 pm"
// 5. Schedule could specify different stations for floor 0 given sufficient staff (e.g. HYHY, MOSC)

#import <Cocoa/Cocoa.h>
#import "Model.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

// Reference to model that all view controllers will use
@property (strong) Model *model;

@end