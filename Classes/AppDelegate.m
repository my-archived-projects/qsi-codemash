//
//  CodeMashAppDelegate.m
//  CodeMash
//
//  Created by Metehan Karabiber on 11/3/09.
//  Copyright 2009 Quick Solutions, Inc. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (Private)
- (void) createEditableCopyOfDatabaseIfNeeded;
@end

@implementation AppDelegate

@synthesize window;
@synthesize tabBarController;

- (void) applicationDidFinishLaunching:(UIApplication *)application {

	[self createEditableCopyOfDatabaseIfNeeded];

	[window addSubview:tabBarController.view];

}

- (void) createEditableCopyOfDatabaseIfNeeded {
	// First, test for existence.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"codemash.sqlite"];

	BOOL success = [fileManager fileExistsAtPath:writableDBPath];
	if (success) 
		return;
	
	// The writable database does not exist, so copy the default to the appropriate location.
	NSError *error;
	NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"codemash.sqlite"];
	success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
	if (!success) {
		NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}
}

- (void) dealloc {
	[tabBarController release]; tabBarController = nil;
	[window release]; window = nil;

	[super dealloc];
}

@end

