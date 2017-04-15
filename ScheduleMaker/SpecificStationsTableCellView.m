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
		AutocompleteTableCellView *cell = (AutocompleteTableCellView *) [tableView makeViewWithIdentifier:@"auto3" owner:self];
		[cell.option3 setStringValue:self.autocompleteOptions[row]];
		return cell;
	}
	
	return nil;
	
}

// Autocomplete code: if table cell is selected, use that string in text field
- (void)tableViewSelectionDidChange:(NSNotification *)notification {
	
	// Find which table sent notification, find row/string selected by user, then put it into text field
	if ([notification object] == self.autocompleteTable1) {
		NSInteger row = [self.autocompleteTable1 selectedRow];
		NSString *selection = self.autocompleteOptions[row];
		self.specific1.stringValue = selection;
	}
	else if ([notification object] == self.autocompleteTable2) {
		NSInteger row = [self.autocompleteTable2 selectedRow];
		NSString *selection = self.autocompleteOptions[row];
		self.specific2.stringValue = selection;
	}
	else if ([notification object] == self.autocompleteTable3) {
		NSInteger row = [self.autocompleteTable3 selectedRow];
		NSString *selection = self.autocompleteOptions[row];
		self.specific3.stringValue = selection;
	}
	
}

@end