//
//  AppDelegate.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 12/26/16.
//  Copyright © 2016 Erica Dominic. All rights reserved.
//

// MAJOR GOALS:
// 1.1 Add drag and drop to DatabaseViewController
// 2.1 Add autocomplete from database feature in Schedule view controller (for names AND specific stations)
// 3.1 Actually do the data processing and making of the schedule in Model.m
//     If we still have staff after all checked stations are assigned, excess staff get put on Float
//     What if *no one* is qualified to do said post (e.g. birthday party)?  Display alert
//     Display alert if some checked stations *cannot* be filled OR summary of floor stations filled with # of staff
// 3.2 Invoke a script that will open LibreOffice and fill in schedule as if Sook has just written it, ready for editing (if necessary) and printing as usual
// 4.1 Revisit DEFAULTs flags and actually implement NSUserDefaults
// 5.1 Make special stations customizable with +/- buttons

// EVENTUAL ADDITIONS:
// Change color of selected row in DatabaseViewController (so it's not dark blue)
// List of stations in RequirementsViewController seem rather arbitrary; ask Sook
// Change table row colors so they alternate:
//- (void)tableView:(NSTableView *)tableView didAddRowView:(nonnull NSTableRowView *)rowView forRow:(NSInteger)row {
//	if (row % 2) {
//		rowView.backgroundColor = [NSColor yellowColor];
//	}
//}
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