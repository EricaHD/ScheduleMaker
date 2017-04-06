//
//  NameTableCellView.h
//  ScheduleMaker
//
//  Created by Erica Dominic on 1/1/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface NameTableCellView : NSTableCellView <NSTableViewDelegate, NSTableViewDataSource>

@property (strong) IBOutlet NSTextField *name;

// Autocomplete code: data array, table and enclosing scroll view for autocomplete functionality
@property (strong) NSMutableArray *autocompleteOptions;
@property (strong) IBOutlet NSTableView *autocompleteTable;
@property (nonatomic, strong) IBOutlet NSScrollView *autocompleteScroll;

@end