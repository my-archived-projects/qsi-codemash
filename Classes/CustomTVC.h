//
//  CustomTVC.h
//  CodeMash
//
//  Created by Metehan Karabiber on 11/15/09.
//  Copyright 2009 Quick Solutions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomTVC : UITableViewController {
	UIView *activityView;
	UIActivityIndicatorView *activityWheel;
	UILabel *actLabel;
}

@property (nonatomic, retain) UIView *activityView;
@property (nonatomic, retain) UIActivityIndicatorView *activityWheel;
@property (nonatomic, retain) UILabel *actLabel;

- (void) createActivityViews;
- (void) loadData;
- (void) fetchRSS;
- (void) hideActivityViewer;
- (void) showActivityViewer;

@end
