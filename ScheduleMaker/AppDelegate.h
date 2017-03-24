//
//  AppDelegate.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 12/26/16.
//  Copyright © 2016 Erica Dominic. All rights reserved.
//

// MAJOR MILESTONES:
// Actually do the data processing and making of the schedule in Model.m (neaten up while you're at it) <--
//     Rename Helper file to ErrorChecking file; move print statements to other helper file called Printing <--
//     Add another "0" and "Float" to RequirementsViewController?
//     Change start time menus in ScheduleViewController to include 8:00 am, 8:30 am, 9:00 am, 9:30 am; change timeEntries <--
// Invoke a script that will open LibreOffice and fill in schedule as if Sook has just written it, ready for editing (if necessary) and printing as usual
// Make special stations customizable with +/- buttons
// Lay out Database view controller
// Add autocomplete from database feature in Schedule view controller (for names AND specific stations)
// Revisit DEFAULTs flags and actually implement NSUserDefaults

// OBJECTIVE-C/XCODE THINGS:
// Go back and figure out which @property need (strong) or other qualifiers
// Go back to NSLog(@"Error: ..."); and handle errors more gracefully
// Intead of doing (viewControllerArray.count == 3) check and if not a clumsy NSLog error message, figure out how to have program WAIT until that condition is true, then do the work of finding the three view controllers within AppDelegate.m

// EVENTUAL ADDITIONS:
// README/instruction booklet describing use of software
// Further error checking?  Like entering only a space " " will count as a valid entry
// Could adds "lunch" or "no lunch" option in case someone wants a lunch but is working <5.5 hours
// Could display messages on the results, i.e. "Gallery must be closed 12-1 pm" or "Only one person stationed on floor -1 during 11-5 pm"
// Schedule could specify different stations for floor 0 given sufficient staff (e.g. HYHY, MOSC)

#import <Cocoa/Cocoa.h>
#import "Model.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

// Reference to model that all view controllers will use
@property (strong) Model *model;

@end