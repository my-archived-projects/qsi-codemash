//
//  CustomTVC.m
//  CodeMash
//
//  Created by Metehan Karabiber on 11/15/09.
//  Copyright 2009 Quick Solutions, Inc. All rights reserved.
//

#import "CustomTVC.h"
#import "AppDelegate.h"


@implementation CustomTVC
@synthesize activityView, activityWheel, actLabel;


- (void)dealloc {
	[activityWheel release]; activityWheel = nil;
	[activityView release]; activityView = nil;
	[actLabel release]; actLabel = nil;
	
   [super dealloc];
}

- (void) createActivityViews {
	AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
	UIView *tabView = delegate.tabBarController.selectedViewController.view;
	
	self.activityView = [[UIView alloc] initWithFrame: CGRectMake(0,0,tabView.bounds.size.width,tabView.bounds.size.height)];
	activityView.backgroundColor = [UIColor blackColor];
	activityView.alpha = 0.9;
	activityView.tag = 10001;
	
	activityWheel = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(tabView.bounds.size.width / 2 - 12, 
																									  tabView.bounds.size.height / 2 - 12, 24, 24)];
	[activityView addSubview:activityWheel];
	
	actLabel = [[UILabel alloc] initWithFrame:CGRectMake(10,
																		  tabView.bounds.size.height / 2 + 20, 300, 24)];
	actLabel.text = @"Loading...";
	actLabel.tag = 10002;
	actLabel.backgroundColor = [UIColor clearColor];
	actLabel.textColor = [UIColor whiteColor];
	actLabel.font = [UIFont boldSystemFontOfSize:15.0];
	actLabel.textAlignment = UITextAlignmentCenter;
	[activityView addSubview:actLabel];
}

- (void) showActivityViewer {
	NSAutoreleasePool *apool = [[NSAutoreleasePool alloc] init];
	AppDelegate *delegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
	UIView *tabView = delegate.tabBarController.selectedViewController.view;
	[tabView	addSubview:activityView];
	
	[activityWheel startAnimating];
	[apool release];
}

- (void) hideActivityViewer {
	NSAutoreleasePool *apool = [[NSAutoreleasePool alloc] init];
	[activityWheel stopAnimating];
	[activityView removeFromSuperview];
	[apool release];
}

- (void) loadData {
}

- (void) fetchRSS {
}

@end

