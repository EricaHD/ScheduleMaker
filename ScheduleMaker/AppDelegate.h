//
//  AppDelegate.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 12/26/16.
//  Copyright © 2016 Erica Dominic. All rights reserved.
//

// TO DO NEXT:
// Learn how to collate and/or pass data between three view controllers <-- working on now
// Make special stations customizable with +/- buttons
// Lay out Database view controller
// Add autocomplete from database feature in Schedule view controller (for names and specific stations)
// Actually do the data processing and making of the schedule
// Invoke a script that will open LibreOffice and fill in schedule as if Sook has just written it, ready for editing (if necessary) and printing as usual
// Go back to DEFAULTs
// Go back to TODOs

// ADDITIONS:
// 1. README/instruction booklet describing use of software
// 2. Further error checking?  Like entering only a space " " will count as a valid entry
// 3. Could adds "lunch" or "no lunch" option in case someone wants a lunch but is working <5.5 hours
// 4. Could display messages on the results, i.e. "Gallery must be closed 12-1 pm" or "Only one person stationed on floor -1 during 11-5 pm"
// 5. Schedule could specify different stations for floor 0 given sufficient staff (e.g. HYHY, MOSC)

#import <Cocoa/Cocoa.h>
#import "Model.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (strong) Model *model;

@end