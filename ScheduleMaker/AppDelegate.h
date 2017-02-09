//
//  AppDelegate.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 12/26/16.
//  Copyright © 2016 Erica Dominic. All rights reserved.
//

// ADDITIONS:
// 1. AUTOCOMPLETION for staff entry!!!  But would then need the ability to view staff "dictionary," and also add/delete/modify entries within it
// 2. README/instruction booklet describing use of software

// POSSIBLE ADDITIONS:
// 3. Could add lunch options to bottom section, underneath "half hours" (e.g. "backload lunches," "hour lunches if possible")
// 4. Could display messages on the results, i.e. "Gallery must be closed 12-1 pm" or "Only one person stationed on floor -1 during 11-5 pm"
// 5. Possibly include fireguard status and follow the 2 fireguard rule (?)
// 6. Schedule could specify different stations for floor 0 given suffiecient staff (e.g. HYHY, MOSC)

// KNOWN ISSUES:
// 1. If you check boxes, then try to select a row outside entry boxes, that row will flash blue very quickly and checkboxes will clear previously entered data

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@end