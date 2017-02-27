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
// 3. Further error checking?  Like entering only a space " " will count as a valid entry

// POSSIBLE ADDITIONS:
// 4. Could add lunch options to bottom section, underneath "half hours" (e.g. "backload lunches," "hour lunches if possible")
// 5. Could display messages on the results, i.e. "Gallery must be closed 12-1 pm" or "Only one person stationed on floor -1 during 11-5 pm"
// 6. Possibly include fireguard status and follow the 2 fireguard rule (?)
// 7. Schedule could specify different stations for floor 0 given suffiecient staff (e.g. HYHY, MOSC)

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@end