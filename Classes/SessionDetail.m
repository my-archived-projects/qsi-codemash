//
//  SessionDetail.m
//  CodeMash
//
//  Created by Metehan Karabiber on 11/6/09.
//  Copyright 2009 Quick Solutions, Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "SessionDetail.h"
#import "CodeMashDAO.h"
#import "Util.h"

#define FONT_SIZE 13.0f

#define CELL_WIDTH 320.0f
#define LEFT_MARGIN 10.0f
#define TOP_MARGIN 5.0f

@interface SessionDetail()
- (CGSize) getSize:(NSString *)text width:(CGFloat)width fontSize:(CGFloat)fontSize;
@end


@implementation SessionDetail
@synthesize session;
@synthesize add;

- (void) viewDidLoad {
   [super viewDidLoad];
	
	self.title = @"Details";
	self.tableView.allowsSelection = NO;

	UIBarButtonItem *navBtn;
	
	if (self.add) {
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
	[navBtn release];
}

- (IBAction) addToMySessions {
	BOOL addSession = [CodeMashDAO insertSession:self.session];
	NSString *message;
	
	if (addSession)	message = @"This session has been added to your sessions!";
	else					message = @"Operation failed! This session could not be added to your sessions.";

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

- (IBAction) removeSession {
	BOOL removeSession = [CodeMashDAO removeSession:self.session];
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

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	[self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSString *text;
	
	if		  (indexPath.row == 0) text = session.title;
	else if (indexPath.row == 1) text = session.speaker.name;
	else if (indexPath.row == 2) text = [session.date stringByAppendingFormat:@" %@", session.time];
	else if (indexPath.row == 3) text = session.difficulty;
	else if (indexPath.row == 4) text = session.sAbstract;

	CGFloat height1 = [Util getHeightWithText:@"Title" withFont:[UIFont boldSystemFontOfSize:(FONT_SIZE+1)] withWidth:(CELL_WIDTH - (LEFT_MARGIN * 2))];
	CGFloat height2 = [Util getHeightWithText:text withFont:[UIFont systemFontOfSize:FONT_SIZE] withWidth:(CELL_WIDTH - (LEFT_MARGIN * 3))];	
	
	return height1 + height2 + (TOP_MARGIN * 3);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   static NSString *CellIdentifier = @"SessionDetailCell";
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	UILabel *topLabel = nil;
	UILabel *bottomLabel = nil;
	UIWebView *webView = nil;

	const NSInteger TOP_LABEL_TAG = 1001;
	const NSInteger BOTTOM_LABEL_TAG = 1002;
	const NSInteger WEB_VIEW_TAG = 1003;
	
   if (cell == nil) {
       cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];

		topLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
		[cell.contentView addSubview:topLabel];

		topLabel.tag = TOP_LABEL_TAG;
		topLabel.font = [UIFont boldSystemFontOfSize:FONT_SIZE+1];

		if (indexPath.row == 4) {
			webView = [[[UIWebView alloc] initWithFrame:CGRectZero] autorelease];
			[cell.contentView addSubview:webView];
		}
		else {
			bottomLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
			[cell.contentView addSubview:bottomLabel];
			
			bottomLabel.numberOfLines = 0;
			bottomLabel.tag = BOTTOM_LABEL_TAG;
			bottomLabel.font = [UIFont systemFontOfSize:FONT_SIZE];		
		}
   }
	else {
		topLabel = (UILabel *) [cell viewWithTag:TOP_LABEL_TAG];
		
		if (indexPath.row == 4)
			webView = (UIWebView *) [cell viewWithTag:WEB_VIEW_TAG]; 
		else
			bottomLabel = (UILabel *) [cell viewWithTag:BOTTOM_LABEL_TAG];
	}

	NSString *text;
	
	if (indexPath.row == 0) {
		topLabel.text = @"Session Title:";
		text = session.title;
	}
	else if (indexPath.row == 1) {
		topLabel.text = @"Speaker:";
		text = session.speaker.name;
	}
	else if (indexPath.row == 2) {
		topLabel.text = @"Schedule:";
		text = session.difficulty;
	}
	else if (indexPath.row == 3) {
		topLabel.text = @"Level:";
		text = [session.date stringByAppendingFormat:@" - %@", session.time];
	}
	else if (indexPath.row == 4) {
		topLabel.text = @"Abstract:";
		text = session.sAbstract;
	}

	CGFloat height1 = [Util getHeightWithText:topLabel.text withFont:[UIFont boldSystemFontOfSize:(FONT_SIZE+1)] withWidth:(CELL_WIDTH - (LEFT_MARGIN * 2))];
	[topLabel setFrame:CGRectMake(LEFT_MARGIN, TOP_MARGIN, CELL_WIDTH - (LEFT_MARGIN * 2), height1)];

	CGFloat height2 = [Util getHeightWithText:text withFont:[UIFont systemFontOfSize:FONT_SIZE] withWidth:(CELL_WIDTH - (LEFT_MARGIN * 3))];
	
	if (webView) {
		[webView setFrame:CGRectMake(LEFT_MARGIN * 2, height1 + TOP_MARGIN * 2, 
											  CELL_WIDTH - (LEFT_MARGIN * 3), height2)];
		[webView loadHTMLString:text baseURL:[NSURL URLWithString:@""]];
	}
	else {
		bottomLabel.text = text;
		[bottomLabel setFrame:CGRectMake(LEFT_MARGIN + LEFT_MARGIN, height1 + TOP_MARGIN * 2, 
													CELL_WIDTH - (LEFT_MARGIN * 3), height2)];
	}
	
	return cell;
}

- (CGSize) getSize:(NSString *)text width:(CGFloat)width fontSize:(CGFloat)fontSize {

	CGSize constraint = CGSizeMake(width, 20000.0f);
	
	return [text sizeWithFont:[UIFont systemFontOfSize:fontSize] 
			  constrainedToSize:constraint 
					lineBreakMode:UILineBreakModeWordWrap];
}
	 
- (void)dealloc {
	[session release]; self.session = nil;
	[super dealloc];
}

@end
