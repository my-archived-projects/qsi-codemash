//
//  NewsDetail.m
//  CodeMash
//
//  Created by Metehan Karabiber on 11/10/09.
//  Copyright 2009 Quick Solutions, Inc.. All rights reserved.
//

#import "NewsDetail.h"
#import "Util.h"

#define FONT_SIZE 14.0f
#define CELL_WIDTH 320.0f
#define MARGIN 5.0f

@interface NewsDetail()
- (NSString *) changeLinks:(NSString *)text;
@end

@implementation NewsDetail
@synthesize story;

- (void) viewDidLoad {
   [super viewDidLoad];
	
	self.navigationItem.title = @"News Details";
	self.tableView.allowsSelection = NO;
}

- (void) dealloc {
	[story release]; story = nil;
   [super dealloc];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

	NSString *text; CGFloat fontSize; BOOL bold;

	if		  (indexPath.row == 0) { text = self.story.title;	 fontSize = FONT_SIZE+2; bold = YES; }
	else if (indexPath.row == 1) { text = self.story.date;	 fontSize = FONT_SIZE-1; bold = YES; }
	else if (indexPath.row == 2) { text = self.story.summary; fontSize = FONT_SIZE; bold = NO; }

	UIFont *font = bold ? [UIFont boldSystemFontOfSize:fontSize] : [UIFont systemFontOfSize:fontSize];

	return [Util getHeightWithText:text withFont:font withWidth:(CELL_WIDTH - (MARGIN * 2))] + (MARGIN * 2);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   static NSString *CellIdentifier = @"Cell";
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	UILabel *label = nil;
	UIWebView *wv = nil;

   if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];

		if (indexPath.row == 0 || indexPath.row == 1) {
			label = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
			label.textAlignment = UITextAlignmentCenter;
			[cell.contentView addSubview:label];
		}
		else {
			wv = [[[UIWebView alloc] initWithFrame:CGRectZero] autorelease];
			[cell.contentView addSubview:wv];
		}
   }

	NSString *wVtext; CGFloat height;
    
	if (indexPath.row == 0) {
		label.font = [UIFont boldSystemFontOfSize:FONT_SIZE + 2];
		label.text = self.story.title;
		label.numberOfLines = 0;

		height = [Util getHeightWithText:label.text withFont:label.font withWidth:(CELL_WIDTH - (MARGIN * 2))];
	}
	else if (indexPath.row == 1) {
		label.font = [UIFont boldSystemFontOfSize:FONT_SIZE - 1];
		label.text = self.story.date;

		height = [Util getHeightWithText:label.text withFont:label.font withWidth:(CELL_WIDTH - (MARGIN * 2))];
		UIView *bgView = [[UIView alloc] initWithFrame:cell.frame];
		bgView.backgroundColor = [UIColor lightGrayColor];
		label.backgroundColor = [UIColor lightGrayColor];
		cell.backgroundView = bgView;
		[bgView release];
	}
	else if (indexPath.row == 2) {
		wVtext = self.story.summary;
		height = [Util getHeightWithText:wVtext withFont:[UIFont systemFontOfSize:FONT_SIZE] withWidth:(CELL_WIDTH - (MARGIN * 2))];
	}

	if (wv) {
		[wv setFrame:CGRectMake(MARGIN, MARGIN, (CELL_WIDTH - (MARGIN * 2)), height)];
		[wv loadHTMLString:[self changeLinks:wVtext] baseURL:[NSURL URLWithString:@""]];
	}
	else
		[label setFrame:CGRectMake(MARGIN, MARGIN, (CELL_WIDTH - (MARGIN * 2)), height)];

	return cell;
}

- (NSString *) changeLinks:(NSString *)text {
	
	NSRange range = [text rangeOfString:@"href" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [text length])];

	if (range.location == NSNotFound)
		return text;

	NSString *style = @"<style>a { font-weight:bold; color:blue; margin:3px; }</style>";
	
	return [style stringByAppendingString:[text stringByReplacingOccurrencesOfString:@"href" withString:@"id"]];
}

@end

