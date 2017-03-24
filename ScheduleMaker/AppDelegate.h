//
//  AppDelegate.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 12/26/16.
//  Copyright © 2016 Erica Dominic. All rights reserved.
//

// MAJOR GOALS:
// 1.1 Add another "0" and one or two "Float"s to RequirementsViewController list?
// 1.2 Lay out Database view controller
// 1.3 Add autocomplete from database feature in Schedule view controller (for names AND specific stations)
// 2.1 Actually do the data processing and making of the schedule in Model.m (neaten up while you're at it)
// 2.2 Invoke a script that will open LibreOffice and fill in schedule as if Sook has just written it, ready for editing (if necessary) and printing as usual
// 3.1 Revisit DEFAULTs flags and actually implement NSUserDefaults
// 4.1 Make special stations customizable with +/- buttons

// EVENTUAL ADDITIONS:
// README/instruction booklet describing use of software
// Further error checking?  Like entering only a space " " will count as a valid entry
// Could adds "lunch" or "no lunch" option in case someone wants a lunch but is working < 5.5 hours
// Could display messages on the results, i.e. "Gallery must be closed 12-1 pm" or "Only one person stationed on floor -1 during 11-5 pm"
// Schedule could specify different stations for floor 0 given sufficient staff (e.g. HYHY, MOSC)
// Go back and figure out which @property need (strong) or other qualifiers

#import <Cocoa/Cocoa.h>
#import "Model.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

// Reference to model that all view controllers will use
@property (strong) Model *model;

@end