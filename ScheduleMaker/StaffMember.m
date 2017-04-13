//
//  StaffMember.m
//  ScheduleMaker
//
//  Created by Erica Dominic on 4/11/17.
//  Copyright © 2017 Erica Dominic. All rights reserved.
//

#import "StaffMember.h"
#import "AppDelegate.h"

// Insert code here to add functionality to your managed object subclass
@implementation StaffMember

// Find and return staff member in database
// Called when edit staff member window pops up triggered in DatabaseViewController.m
+ (StaffMember *)searchStaffMembersByName:(NSString *)name {
	
	// Create context
	AppDelegate *appDelegate = (AppDelegate *) [[NSApplication sharedApplication] delegate];
	NSManagedObjectContext *context = appDelegate.managedObjectContext;
	
	// Request: check that only one database entry has that name
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"StaffMember"];
	request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
	NSError *error;
	NSArray *matches = [context executeFetchRequest:request error:&error];
	
	// If there isn't exactly ONE database entry with that name...
	if (!matches || error || matches.count != 1) {
		// ...report error
		NSLog(@"Error: couldn't find staff member in database (in searchStaffMembersByName).");
	}
	
	// If we found exactly one staff member with that name...
	return [matches firstObject];
	
}

// Add staff member into database and return 0 (unless there is already a staff member in the database with that first name, in which case method returns -1)
// Called when saving data for a new staff member in AddEditStaffViewController.m
+ (int)addStaffMemberFromDictionary:(NSDictionary *)staffMemberInfo {
	
	// Create context
	AppDelegate *appDelegate = (AppDelegate *) [[NSApplication sharedApplication] delegate];
	NSManagedObjectContext *context = appDelegate.managedObjectContext;
	
	// Create entity
	StaffMember *staffMemberEntity = nil;
	
	// Request: check if any other database entries have that first name
	NSString *name = staffMemberInfo[@"name"];
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"StaffMember"];
	request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
	NSError *error;
	NSArray *matches = [context executeFetchRequest:request error:&error];
	
	// If there are already database entries with that first name...
	if (matches && matches.count > 0) {
		// ...report error via return value
		return -1;
	}
	
	// If there are other errors...
	else if (!matches || error) {
		// ...report error
		NSLog(@"Error: couldn't find staff member in database (in editStaffMemberFromDictionary).");
		return 0;
	}
	
	// If there are no database entries with that first name...
	else {
		// ...create object
		staffMemberEntity = [NSEntityDescription insertNewObjectForEntityForName:@"StaffMember" inManagedObjectContext:context];
		staffMemberEntity.name = [staffMemberInfo valueForKey:@"name"];
		staffMemberEntity.trike = [staffMemberInfo valueForKey:@"trike"];
		staffMemberEntity.coro = [staffMemberInfo valueForKey:@"coro"];
		staffMemberEntity.negOne = [staffMemberInfo valueForKey:@"negOne"];
		staffMemberEntity.zero = [staffMemberInfo valueForKey:@"zero"];
		staffMemberEntity.gallery = [staffMemberInfo valueForKey:@"gallery"];
		staffMemberEntity.floating = [staffMemberInfo valueForKey:@"floating"];
		staffMemberEntity.project = [staffMemberInfo valueForKey:@"project"];
		staffMemberEntity.greeting = [staffMemberInfo valueForKey:@"greeting"];
		staffMemberEntity.security = [staffMemberInfo valueForKey:@"security"];
		staffMemberEntity.tours = [staffMemberInfo valueForKey:@"tours"];
		staffMemberEntity.lesson = [staffMemberInfo valueForKey:@"lesson"];
		staffMemberEntity.manager = [staffMemberInfo valueForKey:@"manager"];
		staffMemberEntity.birthday = [staffMemberInfo valueForKey:@"birthday"];
		staffMemberEntity.other = [staffMemberInfo valueForKey:@"other"];
		staffMemberEntity.fireguard = [staffMemberInfo valueForKey:@"fireguard"];

		// ...save object
		NSError *error;
		if (![context save:&error]) {
			NSLog(@"Error: couldn't save changes. %@", [error localizedDescription]);
		}
		
		return 0;
		
	}
	
}

// Edit staff member information
// Called when editing data for a staff member in AddEditStaffViewController.m
+ (void)editStaffMemberFromDictionary:(NSDictionary *)staffMemberInfo {
	
	// Create context
	AppDelegate *appDelegate = (AppDelegate *) [[NSApplication sharedApplication] delegate];
	NSManagedObjectContext *context = appDelegate.managedObjectContext;
	
	// Request: check that only one database entry has that name
	NSString *name = staffMemberInfo[@"name"];
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"StaffMember"];
	request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
	NSError *error;
	NSArray *matches = [context executeFetchRequest:request error:&error];
	
	// If there isn't exactly ONE database entry with that name...
	if (!matches || error || matches.count != 1) {
		// ...report error
		NSLog(@"Error: couldn't find staff member in database (in editStaffMemberFromDictionary).");
	}
	
	// If we found exactly one staff member with that name...
	else {
		// ...edit object
		StaffMember *staffMemberEntity = [matches firstObject];
		staffMemberEntity.trike = [staffMemberInfo valueForKey:@"trike"];
		staffMemberEntity.coro = [staffMemberInfo valueForKey:@"coro"];
		staffMemberEntity.negOne = [staffMemberInfo valueForKey:@"negOne"];
		staffMemberEntity.zero = [staffMemberInfo valueForKey:@"zero"];
		staffMemberEntity.gallery = [staffMemberInfo valueForKey:@"gallery"];
		staffMemberEntity.floating = [staffMemberInfo valueForKey:@"floating"];
		staffMemberEntity.project = [staffMemberInfo valueForKey:@"project"];
		staffMemberEntity.greeting = [staffMemberInfo valueForKey:@"greeting"];
		staffMemberEntity.security = [staffMemberInfo valueForKey:@"security"];
		staffMemberEntity.tours = [staffMemberInfo valueForKey:@"tours"];
		staffMemberEntity.lesson = [staffMemberInfo valueForKey:@"lesson"];
		staffMemberEntity.manager = [staffMemberInfo valueForKey:@"manager"];
		staffMemberEntity.birthday = [staffMemberInfo valueForKey:@"birthday"];
		staffMemberEntity.other = [staffMemberInfo valueForKey:@"other"];
		staffMemberEntity.fireguard = [staffMemberInfo valueForKey:@"fireguard"];
		
		// ...save object
		NSError *error;
		if (![context save:&error]) {
			NSLog(@"Error: couldn't save changes. %@", [error localizedDescription]);
		}
	}
	
}

// Delete staff member with given name from database
// Called when deleting a staff member from the database through DatabaseViewController.m
+ (void)deleteStaffMemberWithName:(NSString *)name {
	
	// Create context
	AppDelegate *appDelegate = (AppDelegate *) [[NSApplication sharedApplication] delegate];
	NSManagedObjectContext *context = appDelegate.managedObjectContext;
	
	// Request: check that only one database entry has that name
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"StaffMember"];
	request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
	NSError *error;
	NSArray *matches = [context executeFetchRequest:request error:&error];
	
	// If there isn't exactly ONE database entry with that name...
	if (!matches || error || matches.count != 1) {
		// ...report error
		NSLog(@"Error: couldn't find staff member in database (in deleteStaffMemberWithName).");
	}
	
	// If we found exactly one staff member with that name...
	else {
		// ...delete it
		[context deleteObject:[matches firstObject]];
		
		// ...save object
		NSError *error;
		if (![context save:&error]) {
			NSLog(@"Error: couldn't save changes. %@", [error localizedDescription]);
		}
	}
	
}

// Return contents of database in an array (array elements are NSDictionaries)
// Called when gathering information to display in the table view in DatabaseViewController.m
+ (NSArray *)getContentsOfDatabase {
	
	// Create context
	AppDelegate *appDelegate = (AppDelegate *) [[NSApplication sharedApplication] delegate];
	NSManagedObjectContext *context = appDelegate.managedObjectContext;
	
	// Request: check that only one database entry has that name
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"StaffMember"];
	NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:true];
	[request setSortDescriptors:@[descriptor]];
	NSError *error;
	NSArray *matches = [context executeFetchRequest:request error:&error];
	
	// Put all matches in results, an array of dictionaries
	NSMutableArray *results = [[NSMutableArray alloc] init];
	for (StaffMember *staffMemberEntity in matches) {
		NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
		dict[@"name"] = staffMemberEntity.name;
		dict[@"trike"] = staffMemberEntity.trike;
		dict[@"coro"] = staffMemberEntity.coro;
		dict[@"negOne"] = staffMemberEntity.negOne;
		dict[@"zero"] = staffMemberEntity.zero;
		dict[@"gallery"] = staffMemberEntity.gallery;
		dict[@"floating"] = staffMemberEntity.floating;
		dict[@"project"] = staffMemberEntity.project;
		dict[@"greeting"] = staffMemberEntity.greeting;
		dict[@"security"] = staffMemberEntity.security;
		dict[@"tours"] = staffMemberEntity.tours;
		dict[@"lesson"] = staffMemberEntity.lesson;
		dict[@"manager"] = staffMemberEntity.manager;
		dict[@"birthday"] = staffMemberEntity.birthday;
		dict[@"other"] = staffMemberEntity.other;
		dict[@"fireguard"] = staffMemberEntity.fireguard;
		[results addObject:dict];
	}
	
	// Return array of dictionaries describing staff members in database
	return results;
	
}

// Return array of strings: staff member names which begin with given substrings (checks capitalized and uncapitalized)
// Called within the autocomplete code for name text fields in ScheduleViewController.m
+ (NSArray *)searchStaffMembersBeginningWith:(NSString *)substring {
	
	// Capitalize user-entered substring
	NSString *capitalizedSubstring = [substring capitalizedString];
	
	// Create context
	AppDelegate *appDelegate = (AppDelegate *) [[NSApplication sharedApplication] delegate];
	NSManagedObjectContext *context = appDelegate.managedObjectContext;
	
	// Request: check that only one database entry has that name
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"StaffMember"];
	request.predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH %@ || name BEGINSWITH %@", substring, capitalizedSubstring];
	NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:true];
	[request setSortDescriptors:@[descriptor]];
	NSError *error;
	NSArray *matches = [context executeFetchRequest:request error:&error];
	
	// Put all matches in results, an array of dictionaries
	NSMutableArray *results = [[NSMutableArray alloc] init];
	for (StaffMember *staffMemberEntity in matches) {
		[results addObject:staffMemberEntity.name];
	}
	
	// Return array of dictionaries describing staff members in database
	return results;
	
}

// Get number of entries currently in StaffMember entity
// Called when determining number of rows in table view in DatabaseViewController.m
+ (NSInteger)getNumberOfEntries {
	
	// Create context
	AppDelegate *appDelegate = (AppDelegate *) [[NSApplication sharedApplication] delegate];
	NSManagedObjectContext *context = appDelegate.managedObjectContext;
	
	// Request: check that only one database entry has that name
	NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"StaffMember"];
	NSError *error;
	
	// Returns the number of objects a given fetch request would have returned
	NSUInteger count = [context countForFetchRequest:request error:&error];
	if (count == NSNotFound) {
		NSLog(@"Error: can't find number of entries in entity.");
	}
	return count;

}

@end