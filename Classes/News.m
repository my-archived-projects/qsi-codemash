//
//  News.m
//  CodeMash
//
//  Created by Metehan Karabiber on 11/10/09.
//  Copyright 2009 Quick Solutions, Inc.. All rights reserved.
//

#import "News.h"
#import "NewsDetail.h"
#import "AppDelegate.h"
#import "NewsFetcher.h"
#import "Util.h"

#define MARGIN 5.0

@implementation News

@synthesize stories;

- (void) viewDidLoad {
   [super viewDidLoad];

	self.title = @"News";

	UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(loadData)];
	self.navigationItem.rightBarButtonItem = btn;
	[btn release];

	[self createActivityViews];
	[self loadData];
}

- (void) dealloc {
	[stories release];	stories = nil;
	[super dealloc];
}

- (void) loadData {
	self.stories = nil;
	[self.tableView reloadData];
	
	[self performSelectorInBackground:@selector(showActivityViewer) withObject:nil];
	[self performSelectorInBackground:@selector(fetchRSS) withObject:nil];
}

- (void) fetchRSS {
	NSAutoreleasePool *apool = [[NSAutoreleasePool alloc] init];

	if (stories == nil || [stories count] == 0) {
		NewsFetcher *fetcher = [[NewsFetcher alloc] init];
		self.stories = [[NSArray arrayWithArray:fetcher.objects] retain];
		[fetcher release];

		[self.tableView reloadData];
	}

	[self performSelectorInBackground:@selector(hideActivityViewer) withObject:nil];
	[apool release];
}

#pragma mark Table view methods

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [stories count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	Story *item = (Story *) [stories objectAtIndex:indexPath.row];

	CGFloat height1 = [Util getHeightWithText:item.title withFont:[UIFont boldSystemFontOfSize:14.0] withWidth:275.0];
	CGFloat height2 = [Util getHeightWithText:item.date withFont:[UIFont systemFontOfSize:12.0] withWidth:80.0];
	
	return height1 + height2 + (MARGIN * 3);
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	const NSInteger TITLE_TAG = 1001;
	const NSInteger DATE_TAG = 1002;

	static NSString *CellIdentifier = @"News";
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

	UILabel *title, *date;

	if (cell == nil) {
//		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		
		title = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
		[cell.contentView addSubview:title];

		title.tag = TITLE_TAG;
		title.numberOfLines = 0;
		title.font = [UIFont boldSystemFontOfSize:14.0];
		
		date = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
		[cell.contentView addSubview:date];

		date.font = [UIFont systemFontOfSize:12.0];
		date.textColor = [UIColor blueColor];
		date.tag = DATE_TAG;
	}
	else {
		title = (UILabel *)[cell viewWithTag:TITLE_TAG];
		date = (UILabel *)[cell viewWithTag:DATE_TAG];
	}

	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	Story *item = (Story *) [stories objectAtIndex:indexPath.row];
	title.text = item.title;	
	date.text = item.date;
	
	CGFloat height1 = [Util getHeightWithText:item.title withFont:[UIFont boldSystemFontOfSize:14.0] withWidth:280.0];
	CGFloat height2 = [Util getHeightWithText:item.date withFont:[UIFont systemFontOfSize:12.0] withWidth:80.0];
	
	title.frame = CGRectMake(MARGIN, MARGIN, 275.0, height1);
	date.frame = CGRectMake(220, (MARGIN * 2) + height1, 80, height2);
	
	return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NewsDetail *newsDtVC = [[NewsDetail alloc] initWithNibName:@"NewsDetail" bundle:nil];
	newsDtVC.story = (Story *) [stories objectAtIndex:indexPath.row];

	[self.navigationController pushViewController:newsDtVC animated:YES];
	[newsDtVC release];
}

@end

