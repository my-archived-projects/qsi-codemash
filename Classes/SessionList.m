//
//  SessionList.m
//  CodeMash
//
//  Created by Metehan Karabiber on 11/5/09.
//  Copyright 2009 Quick Solutions, Inc. All rights reserved.
//

#import "SessionList.h"
#import "SessionDetail.h"
#import "SessionFetcher.h"
#import "DataProvider.h"
#import "CodeMashDAO.h"
#import "AppDelegate.h"
#import "Util.h"

#define FONT_SIZE 13.0f
#define CELL_WIDTH 320.0f
#define MARGIN 5.0f

@implementation SessionList
@synthesize sessionList, sentIndexPath;

enum ButtonTableSections {
	kAllSessionsSection = 0,
	kLevelsSection
};

- (void) viewDidLoad {
   [super viewDidLoad];
	
	if (self.sentIndexPath.section == kAllSessionsSection) {
		self.title = @"All Sessions";
	}
	else if (self.sentIndexPath.section == kLevelsSection) {
		self.title = [[DataProvider getLevels] objectAtIndex:sentIndexPath.row];
	}
	
	[self createActivityViews];
	[self loadData];
}

- (void) dealloc {
	[sessionList release];		self.sessionList = nil;
	[sentIndexPath release];	self.sentIndexPath = nil;
	[super dealloc];
}

- (void) loadData {
	self.sessionList = nil;
	[self.tableView reloadData];
	
	[self performSelectorInBackground:@selector(showActivityViewer) withObject:nil];
	[self performSelectorInBackground:@selector(fetchRSS) withObject:nil];
}

- (void) fetchRSS {
	NSAutoreleasePool *apool = [[NSAutoreleasePool alloc] init];
	
	if (sessionList == nil || [sessionList count] == 0) {
		SessionFetcher *fetcher = [[SessionFetcher alloc] init];
		self.sessionList = [[NSArray arrayWithArray:fetcher.objects] retain];
		[fetcher release];
		
		[self.tableView reloadData];
	}
	
	[self performSelectorInBackground:@selector(hideActivityViewer) withObject:nil];
	[apool release];
}

- (IBAction) addToMySessions:(Session *)session {
	BOOL addSession = [CodeMashDAO insertSession:session];
	NSString *message;
	
	if (addSession)	message = @"This session has been added to your sessions!";
	else					message = @"Operation failed! This session could not be added to your sessions.";
	
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:message 
																				delegate:self
																	cancelButtonTitle:@"Dismiss" 
															 destructiveButtonTitle:nil
																	otherButtonTitles:nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	actionSheet.delegate = self;
	
	AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
	[actionSheet showInView:appDelegate.tabBarController.view];
	[actionSheet release];
}

- (IBAction) removeSession:(Session *)session {
	BOOL removeSession = [CodeMashDAO removeSession:session];
	NSString *message;
	
	if (removeSession)	message = @"This session has been removed from your sessions!";
	else					message = @"Operation failed! This session could not be removed from your sessions.";
	
	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:message 
																				delegate:self
																	cancelButtonTitle:@"Dismiss" 
															 destructiveButtonTitle:nil
																	otherButtonTitles:nil];
	actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
	
	AppDelegate *appDelegate = (AppDelegate*) [[UIApplication sharedApplication] delegate];
	[actionSheet showInView:appDelegate.tabBarController.view];
	[actionSheet release];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [sessionList count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (sessionList != nil) {
		Session *session = (Session *)[sessionList objectAtIndex:indexPath.row];
		
		return MAX(54.0f, [Util getHeightWithText:session.title 
													withFont:[UIFont systemFontOfSize:FONT_SIZE] 
												  withWidth:280.0f] 
								+ (MARGIN * 2)
					  );
	}
	else {
		return 54.0f;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
   static NSString *CellIdentifier = @"SessionListCell";
    
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	UILabel *label; 

   if (cell == nil) {
      cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		
		label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
		[cell.contentView addSubview:label];

		label.tag = 6001;
		label.numberOfLines = 0;
		label.font = [UIFont systemFontOfSize:FONT_SIZE];
	}
	else {
		label = (UILabel *)[cell viewWithTag:6001];
	}

	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;

	Session *session = (Session *)[sessionList objectAtIndex:indexPath.row];
	label.text = session.title;

	CGFloat height = MAX(44.0, [Util getHeightWithText:label.text withFont:label.font withWidth:280.0f]);
	label.frame = CGRectMake(MARGIN, MARGIN, 280.0f, height);

	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Session *session = (Session *) [sessionList objectAtIndex:indexPath.row];
	BOOL add = [CodeMashDAO sessionAlreadyAdded:session] == NO;

	UIBarButtonItem *navBtn;
	
	if (add) {
		navBtn = [[UIBarButtonItem alloc] initWithTitle:@"Add" 
																style:UIBarButtonItemStyleDone
															  target:self 
															  action:@selector(addToMySessions)];
	}
	else {
		navBtn = [[UIBarButtonItem alloc] initWithTitle:@"Remove" 
																style:UIBarButtonItemStyleDone
															  target:self 
															  action:@selector(removeSession)];
	}

	self.navigationItem.rightBarButtonItem = navBtn;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	Session *session = (Session *) [sessionList objectAtIndex:indexPath.row];
	
	SessionDetail *sessionDetail = [[SessionDetail alloc] initWithStyle:UITableViewStylePlain];
	sessionDetail.session = session;
	sessionDetail.add = [CodeMashDAO sessionAlreadyAdded:session] == NO;
	
	[self.navigationController pushViewController:sessionDetail animated:YES];
	[sessionDetail release];
}

@end
