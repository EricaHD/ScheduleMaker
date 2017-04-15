//
//  AppDelegate.m
//  ScheduleMaker
//
//  Created by Erica Dominic on 12/26/16.
//  Copyright © 2016 Erica Dominic. All rights reserved.
//

#import "AppDelegate.h"
#import "DatabaseViewController.h"
#import "RequirementsViewController.h"
#import "ScheduleViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

// Insert code here to initialize your application
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	
	// Set up NSUserDefaults for RequirementsViewController (if they have never been set before)
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if (![defaults objectForKey:@"stationList"]) {
		NSMutableArray *stationList = [NSMutableArray arrayWithObjects:@"Trike", @"Coro", @"Gallery", @"-1", @"-1", @"-1", @"0", @"0", @"0", @"Float", @"Float", @"Project", @"Project", @"Greeting", @"Security", @"Tours", @"Lesson", @"Manager", @"Birthday", @"Other", nil];
		[defaults setObject:stationList forKey:@"stationList"];
	}
	if (![defaults objectForKey:@"stationData"]) {
		NSMutableArray *stationData = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
		[defaults setObject:stationData forKey:@"stationData"];
	}
	if (![defaults objectForKey:@"stationStartTimeData"]) {
		NSMutableArray *stationStartTimeData = [NSMutableArray arrayWithObjects:@"10:00 am", @"10:00 am", @"10:00 am", @"10:00 am", @"10:00 am", @"10:00 am", @"10:00 am", @"10:00 am", @"10:00 am", @"10:00 am", @"10:00 am", @"10:00 am", @"10:00 am", @"10:00 am", @"10:00 am", @"10:00 am", @"10:00 am", @"10:00 am", @"10:00 am", @"10:00 am", nil];
		[defaults setObject:stationStartTimeData forKey:@"stationStartTimeData"];
	}
	if (![defaults objectForKey:@"stationEndTimeData"]) {
		NSMutableArray *stationEndTimeData = [NSMutableArray arrayWithObjects:@"5:00 pm", @"5:00 pm", @"5:00 pm", @"5:00 pm", @"5:00 pm", @"5:00 pm", @"5:00 pm", @"5:00 pm", @"5:00 pm", @"5:00 pm", @"5:00 pm", @"5:00 pm", @"5:00 pm", @"5:00 pm", @"5:00 pm", @"5:00 pm", @"5:00 pm", @"5:00 pm", @"5:00 pm", @"5:00 pm", nil];
		[defaults setObject:stationEndTimeData forKey:@"stationEndTimeData"];
	}
	if (![defaults objectForKey:@"stationFrequencyData"]) {
		NSMutableArray *stationFrequencyData = [NSMutableArray arrayWithObjects:@"With schedule", @"With schedule", @"With schedule", @"With schedule", @"With schedule", @"With schedule", @"With schedule", @"With schedule", @"With schedule", @"With schedule", @"With schedule", @"With schedule", @"With schedule", @"With schedule", @"With schedule", @"With schedule", @"With schedule", @"With schedule", @"With schedule", @"With schedule", nil];
		[defaults setObject:stationFrequencyData forKey:@"stationFrequencyData"];
	}
	if (![defaults objectForKey:@"halfHourData"]) {
		NSMutableArray *halfHourData = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil];
		[defaults setObject:halfHourData forKey:@"halfHourData"];
	}
	if (![defaults objectForKey:@"stackLunchesData"]) {
		NSMutableArray *stackLunchesData = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
		[defaults setObject:stackLunchesData forKey:@"stackLunchesData"];
	}
	
	[defaults synchronize];
	
}

// Set up arrays in model
- (void)setUpModelsArrays {
	
	// Set up ScheduleViewController table
	self.model.nameData = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", nil];
	self.model.startTimeData = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", nil];
	self.model.endTimeData = [NSMutableArray arrayWithObjects:@"", @"", @"", @"", nil];
	self.model.specificStationsData = [NSMutableArray arrayWithObjects:
									   [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", nil],
									   [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", nil],
									   [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", nil],
									   [NSMutableArray arrayWithObjects:@"", @"", @"", @"", @"", @"", @"", @"", @"", nil], nil];
	self.model.lunchData = [NSMutableArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil];
	
	// Set up RequirementsViewController table and checkboxes on the right side of the view (copies of NSUserDefaults)
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	self.model.stationList = [NSMutableArray arrayWithArray:[defaults objectForKey:@"stationList"]];
	self.model.stationData = [NSMutableArray arrayWithArray:[defaults objectForKey:@"stationData"]];
	self.model.stationStartTimeData = [NSMutableArray arrayWithArray:[defaults objectForKey:@"stationStartTimeData"]];
	self.model.stationEndTimeData = [NSMutableArray arrayWithArray:[defaults objectForKey:@"stationEndTimeData"]];
	self.model.stationFrequencyData = [NSMutableArray arrayWithArray:[defaults objectForKey:@"stationFrequencyData"]];
	self.model.halfHourData = [NSMutableArray arrayWithArray:[defaults objectForKey:@"halfHourData"]];
	self.model.stackLunchesData = [NSMutableArray arrayWithArray:[defaults objectForKey:@"stackLunchesData"]];
	
}

// Sent by the default notification center immediately after the application becomes active
- (void)applicationDidBecomeActive:(NSNotification *)notification {
	
	// If the model has not been made yet (so only do once)...
	if (self.model == nil) {
		
		// ...create the model that all view controllers will share
		self.model = [[Model alloc] init];
		
		// Set up arrays in model
		[self setUpModelsArrays];
		
		// Find and set title of window
		NSWindow *window = [[NSApplication sharedApplication] mainWindow];
		window.title = @"MoMath Floor Schedule Generator";
		
		// Find the three view controllers (hardcoded to be three)
		DatabaseViewController *database;
		RequirementsViewController *requirements;
		ScheduleViewController *schedule;
		NSDate* date = [NSDate date];
		while (TRUE) {
			// Ready to do the work
			if (window.contentViewController.childViewControllers.count == 3) {
				NSArray *viewControllerArray = window.contentViewController.childViewControllers;
				database = (DatabaseViewController *) viewControllerArray[0];
				requirements = (RequirementsViewController *) viewControllerArray[1];
				schedule = (ScheduleViewController *) viewControllerArray[2];
				break;
			}
			// Condition is not reached before timeout (giving program 600 seconds = 10 minutes to get this while loop done)
			if ([date timeIntervalSinceNow] < -600) {
				NSLog(@"Error: program timed out");
				break;
			}
			// Suspend thread execution for 10,000 microseconds = 0.01 seconds
			usleep(10000);
		}

		// Point each controller to the model created above
		database.model = self.model;
		requirements.model = self.model;
		schedule.model = self.model;
		
		// Reload tables now that the view controllers are hooked up to the model
		// So that numberOfRowsInTableView method can return something > 0
		// Also reload checkboxes on the side of the requirements view controller
		[schedule.table reloadData];
		[requirements.table reloadData];
		[database.table reloadData];
		[requirements reloadHalfHourData];
		[requirements reloadStackLunchesData];
		
	}
	
}

// Ensure applicationWillTerminate() is called when window is closed
- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender {
	return true;
}

// Insert code here to tear down your application
- (void)applicationWillTerminate:(NSNotification *)aNotification {
	
	// scrapeData() in RequirementsViewController was automatically called already
	// Gather updates on NSUserDefaults
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:self.model.stationList forKey:@"stationList"];
	[defaults setObject:self.model.stationData forKey:@"stationData"];
	[defaults setObject:self.model.stationStartTimeData forKey:@"stationStartTimeData"];
	[defaults setObject:self.model.stationEndTimeData forKey:@"stationEndTimeData"];
	[defaults setObject:self.model.stationFrequencyData forKey:@"stationFrequencyData"];
	[defaults setObject:self.model.halfHourData forKey:@"halfHourData"];
	[defaults setObject:self.model.stackLunchesData forKey:@"stackLunchesData"];
	
}

#pragma mark - Core Data stack #################################################

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;

- (NSURL *)applicationDocumentsDirectory {
	// The directory the application uses to store the Core Data store file. This code uses a directory named "com.ericadominic.ScheduleMaker" in the user's Application Support directory.
	NSURL *appSupportURL = [[[NSFileManager defaultManager] URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
	return [appSupportURL URLByAppendingPathComponent:@"com.ericadominic.ScheduleMaker"];
}

- (NSManagedObjectModel *)managedObjectModel {
	// The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
	if (_managedObjectModel) {
		return _managedObjectModel;
	}
	
	NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"ScheduleMaker" withExtension:@"momd"];
	_managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
	return _managedObjectModel;
}

// If I need to replace this: http://stackoverflow.com/questions/33801858/ios-app-mistakenly-creating-multiple-sqlite-files-for-a-test-case-thus-leading
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {

	// The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it. (The directory for the store is created, if necessary.)
	if (_persistentStoreCoordinator) {
		return _persistentStoreCoordinator;
	}
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSURL *applicationDocumentsDirectory = [self applicationDocumentsDirectory];
	BOOL shouldFail = NO;
	NSError *error = nil;
	NSString *failureReason = @"There was an error creating or loading the application's saved data.";
	
	// Make sure the application files directory is there
	NSDictionary *properties = [applicationDocumentsDirectory resourceValuesForKeys:@[NSURLIsDirectoryKey] error:&error];
	if (properties) {
		if (![properties[NSURLIsDirectoryKey] boolValue]) {
			failureReason = [NSString stringWithFormat:@"Expected a folder to store application data, found a file (%@).",[applicationDocumentsDirectory path]];
	            shouldFail = YES;
		}
	} else if ([error code] == NSFileReadNoSuchFileError) {
		error = nil;
		[fileManager createDirectoryAtPath:[applicationDocumentsDirectory path] withIntermediateDirectories:YES attributes:nil error:&error];
	}
	
	if (!shouldFail && !error) {
		NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
		NSURL *url = [applicationDocumentsDirectory URLByAppendingPathComponent:@"OSXCoreDataObjC.storedata"];
		if (![coordinator addPersistentStoreWithType:NSXMLStoreType configuration:nil URL:url options:nil error:&error]) {
			coordinator = nil;
		}
		_persistentStoreCoordinator = coordinator;
	}
	
	if (shouldFail || error) {
		// Report any error we got.
		NSMutableDictionary *dict = [NSMutableDictionary dictionary];
		dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
		dict[NSLocalizedFailureReasonErrorKey] = failureReason;
		if (error) {
			dict[NSUnderlyingErrorKey] = error;
		}
		error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
		[[NSApplication sharedApplication] presentError:error];
	}
	return _persistentStoreCoordinator;
	
}

- (NSManagedObjectContext *)managedObjectContext {
	// Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
	if (_managedObjectContext) {
		return _managedObjectContext;
	}
	
	NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
	if (!coordinator) {
		return nil;
	}
	_managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
	[_managedObjectContext setPersistentStoreCoordinator:coordinator];
	
	return _managedObjectContext;
}

#pragma mark - Core Data Saving and Undo support ###############################

- (IBAction)saveAction:(id)sender {
	// Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
	if (![[self managedObjectContext] commitEditing]) {
		NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
	}
	
	NSError *error = nil;
	if ([[self managedObjectContext] hasChanges] && ![[self managedObjectContext] save:&error]) {
		[[NSApplication sharedApplication] presentError:error];
	}
}

- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window {
	// Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
	return [[self managedObjectContext] undoManager];
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender {
	// Save changes in the application's managed object context before the application terminates.
	
	if (!_managedObjectContext) {
		return NSTerminateNow;
	}
	
	if (![[self managedObjectContext] commitEditing]) {
		NSLog(@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd));
		return NSTerminateCancel;
	}
	
	if (![[self managedObjectContext] hasChanges]) {
		return NSTerminateNow;
	}
	
	NSError *error = nil;
	if (![[self managedObjectContext] save:&error]) {
		
		// Customize this code block to include application-specific recovery steps.
		BOOL result = [sender presentError:error];
		if (result) {
			return NSTerminateCancel;
		}
		
		NSString *question = NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Quit without saves error question message");
		NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
		NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
		NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
		NSAlert *alert = [[NSAlert alloc] init];
		[alert setMessageText:question];
		[alert setInformativeText:info];
		[alert addButtonWithTitle:quitButton];
		[alert addButtonWithTitle:cancelButton];
		
		NSInteger answer = [alert runModal];
		
		if (answer == NSAlertFirstButtonReturn) {
			return NSTerminateCancel;
		}
	}
	
	return NSTerminateNow;
}

@end