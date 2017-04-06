//
//  NameTableCellView.m
//  ScheduleMaker
//
//  Created by Erica Dominic on 1/1/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import "NameTableCellView.h"
#import "AutocompleteTableCellView.h"

#define ROW_HEIGHT 17.0

@implementation NameTableCellView

// Drawing code here
- (void)drawRect:(NSRect)dirtyRect {
	
	// Super
	[super drawRect:dirtyRect];
	
	// Autocomplete code: set table attributes and update, then hide table
	self.autocompleteTable.rowHeight = ROW_HEIGHT;
	[self.autocompleteTable setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleNone];
	[self.autocompleteTable reloadData];
	self.autocompleteScroll.hidden = YES;
	
}

// Autocomplete code: returns the number of autocomplete options to display
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
	
	return self.autocompleteOptions.count;
	
}

// Autocomplete code: provides the table with the view to display in the cell at a specific column and row; also populates that cell with the appropriate data
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {

	AutocompleteTableCellView *cell = (AutocompleteTableCellView *) [tableView makeViewWithIdentifier:@"auto" owner:self];
	[cell.option setStringValue:self.autocompleteOptions[row]];
	return cell;

}

// Autocomplete code: if table cell is selected, use that string in text field
- (void)tableViewSelectionDidChange:(NSNotification *)notification {
	
	// Put cell's string in text field
	NSInteger row = [self.autocompleteTable selectedRow];
	NSString *selection = self.autocompleteOptions[row];
	self.name.stringValue = selection;
	
}

@end