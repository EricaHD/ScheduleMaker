//
//  AppDelegate.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 12/26/16.
//  Copyright © 2016 Erica Dominic. All rights reserved.
//

// MAJOR GOALS:
// 1. Actually do the data processing and making of the schedule in Model.m
//      If we still have staff after all checked stations are assigned, excess staff get put on Float
//      What if *no one* is qualified to do said post (e.g. birthday party)?  Display alert
//      Finish with summary of floor stations filled with # of staff
// 2. Invoke a script that will open LibreOffice and fill in schedule as if Sook has just written it, ready for editing (if necessary) and printing as usual

// EVENTUALLY:
// Make special stations customizable with +/- buttons
// Resize autocomplete tables when there is only one item suggested
// Change color of selected row in DatabaseViewController (so it's not dark blue)
// Allow requirements view controller to specify multiple time periods for each station, i.e. gallery 10-11 and 2-5
// README/instruction booklet describing use of software
// Further error checking?  E.g. entering only a space " " will count as a valid entry.  E.g. you can force two people on trike simultaneously
// Add "lunch" or "no lunch" option in case someone wants a lunch but is working < 5.5 hours
// Could display messages on the results, i.e. "Gallery must be closed 12-1 pm" or "Only one person stationed on floor -1 during 11-5 pm"
// Schedule could specify different stations for floor 0 given sufficient staff (e.g. HYHY, MOSC)
// Go back and figure out which @properties need (strong) or other qualifiers
// Try debugging and unit tests in this xcode program
// Change table row colors so they alternate:
//     - (void)tableView:(NSTableView *)tableView didAddRowView:(nonnull NSTableRowView *)rowView forRow:(NSInteger)row {
//	      if (row % 2) {
//		     rowView.backgroundColor = [NSColor yellowColor];
//	      }
//     }

#import <Cocoa/Cocoa.h>
#import "Model.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

// Reference to model that all view controllers will use
@property (strong) Model *model;

// Core data properties
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end