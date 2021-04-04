//
//  Sessions.m
//  CodeMash
//
//  Created by Metehan Karabiber on 11/4/09.
//  Copyright 2009 Quick Solutions, Inc. All rights reserved.
//

#import "Sessions.h"
#import "SessionList.h"
#import "DataProvider.h"
#import "SessionFetcher.h"
#import "SpeakerFetcher.h"
#import "CodeMashDAO.h"
#import "AppDelegate.h"

#define FETCH_FLAG	@"FETCH_FLAG"

@implementation Sessions

@synthesize levels;

enum TableSections {
	kAllSessionsSection = 0,
	kLevelsSection
};

- (void)viewDidLoad {
   [super viewDidLoad];
	levels = [[DataProvider getLevels] retain];
	
	if ([[NSUserDefaults standardUserDefaults] boolForKey:FETCH_FLAG] == NO) {
		[self createActivityViews];
		[self loadData];
	}
}

- (void) loadData {
	[self performSelectorInBackground:@selector(showActivityViewer) withObject:nil];
	[self performSelectorInBackground:@selector(fetchRSS) withObject:nil];
}

- (void) fetchRSS {
	NSAutoreleasePool *apool = [[NSAutoreleasePool alloc] init];

	actLabel.text = @"Please wait while fetching data...";
	SessionFetcher *sessionfetcher = [[SessionFetcher alloc] init];
	NSArray *sessions = [[NSArray arrayWithArray:sessionfetcher.objects] retain];
	[sessionfetcher release];
	
	SpeakerFetcher *speakerfetcher = [[SpeakerFetcher alloc] init];
	NSArray *speakers = [[NSArray arrayWithArray:speakerfetcher.objects] retain];
	[speakerfetcher release];

	BOOL flag = [CodeMashDAO insertSessions:sessions];
	NSLog(@"%@", sessions);
	
	flag = [CodeMashDAO insertSessions:speakers];
	NSLog(@"%@", speakers);
	
	[self performSelectorInBackground:@selector(hideActivityViewer) withObject:nil];
	[apool release];
}

- (void)dealloc {
	[levels release];	self.levels = nil;
	[super dealloc];
}

#pragma mark Table view methods

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {

	if (section == kAllSessionsSection)	return @"All";
	else if (section == kLevelsSection)	return @"By Levels";
	
	return @"";
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 38;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	if (section	== kAllSessionsSection)	return 1;
	else if (section == kLevelsSection)	return 3;
	
	return 0;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   static NSString *CellIdentifier = @"SessionsCell";

   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   if (cell == nil) {
       cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
   }
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	if (indexPath.section == kAllSessionsSection)
		[cell.textLabel setText:@"All Sessions"];
	else 
		[cell.textLabel setText:[levels objectAtIndex:indexPath.row]];

   return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

	SessionList *sessionListVC = [[SessionList alloc] init];
	sessionListVC.sentIndexPath = indexPath;
	
	[self.navigationController pushViewController:sessionListVC animated:YES];
	[sessionListVC release];
}

@end