//
//  SpecificStationsTableCellView.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 2/7/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SpecificStationsTableCellView : NSTableCellView  <NSTableViewDelegate, NSTableViewDataSource>

@property (strong) IBOutlet NSTextField *specific1;
@property (strong) IBOutlet NSPopUpButton *specific1_starttime;
@property (strong) IBOutlet NSPopUpButton *specific1_endtime;
@property (strong) IBOutlet NSTextField *specific2;
@property (strong) IBOutlet NSPopUpButton *specific2_starttime;
@property (strong) IBOutlet NSPopUpButton *specific2_endtime;
@property (strong) IBOutlet NSTextField *specific3;
@property (strong) IBOutlet NSPopUpButton *specific3_starttime;
@property (strong) IBOutlet NSPopUpButton *specific3_endtime;

// Autocomplete code: data array, table and enclosing scroll view for autocomplete functionality
@property (strong) NSMutableArray *autocompleteOptions;
@property (strong) IBOutlet NSTableView *autocompleteTable1;
@property (nonatomic, strong) IBOutlet NSScrollView *autocompleteScroll1;
@property (strong) IBOutlet NSTableView *autocompleteTable2;
@property (nonatomic, strong) IBOutlet NSScrollView *autocompleteScroll2;
@property (strong) IBOutlet NSTableView *autocompleteTable3;
@property (nonatomic, strong) IBOutlet NSScrollView *autocompleteScroll3;

@end