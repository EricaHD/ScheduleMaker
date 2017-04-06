//
//  SpecificStationsTableCellView.m
//  ScheduleMaker
//
//  Created by Erica Dominic on 2/7/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import "SpecificStationsTableCellView.h"
#import "AutocompleteTableCellView.h"

#define ROW_HEIGHT 17.0

@implementation SpecificStationsTableCellView

// Drawing code here
- (void)drawRect:(NSRect)dirtyRect {
	
	// Super
	[super drawRect:dirtyRect];
	
	// Autocomplete code: set table attributes and update, then hide table
	self.autocompleteTable1.rowHeight = ROW_HEIGHT;
	self.autocompleteTable2.rowHeight = ROW_HEIGHT;
	self.autocompleteTable3.rowHeight = ROW_HEIGHT;
	[self.autocompleteTable1 setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleNone];
	[self.autocompleteTable2 setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleNone];
	[self.autocompleteTable3 setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleNone];
	[self.autocompleteTable1 reloadData];
	[self.autocompleteTable2 reloadData];
	[self.autocompleteTable3 reloadData];
	self.autocompleteScroll1.hidden = YES;
	self.autocompleteScroll2.hidden = YES;
	self.autocompleteScroll3.hidden = YES;
	
}

// Autocomplete code: returns the number of autocomplete options to display
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
	
	return self.autocompleteOptions.count;
	
}

// Autocomplete code: provides the table with the view to display in the cell at a specific column and row; also populates that cell with the appropriate data
- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
	
	if (tableView == self.autocompleteTable1) {
		AutocompleteTableCellView *cell = (AutocompleteTableCellView *) [tableView makeViewWithIdentifier:@"auto1" owner:self];
		[cell.option1 setStringValue:self.autocompleteOptions[row]];
		return cell;
	}
	else if (tableView == self.autocompleteTable2) {
		AutocompleteTableCellView *cell = (AutocompleteTableCellView *) [tableView makeViewWithIdentifier:@"auto2" owner:self];
		[cell.option2 setStringValue:self.autocompleteOptions[row]];
		return cell;
	}
	else if (tableView == self.autocompleteTable3) {
		NSLog(@"%@", self.autocompleteOptions);
		AutocompleteTableCellView *cell = (AutocompleteTableCellView *) [tableView makeViewWithIdentifier:@"auto3" owner:self];
		[cell.option3 setStringValue:self.autocompleteOptions[row]];
		return cell;
	}
	
	return nil;
	
}

// Autocomplete code: if table cell is selected, use that string in text field TODO
//- (void)tableViewSelectionDidChange:(NSNotification *)notification {
//	
//	// Put cell's string in text field TODO
//	NSInteger row = [self.autocompleteTable selectedRow];
//	NSString *selection = self.autocompleteOptions[row];
//	self.name.stringValue = selection;
//	
//}

@end