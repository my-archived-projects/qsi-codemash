//
//  SessionList.h
//  CodeMash
//
//  Created by Metehan Karabiber on 11/5/09.
//  Copyright 2009 Quick Solutions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Session.h"
#import "CustomTVC.h"

@interface SessionList : CustomTVC <UIActionSheetDelegate> {
	NSArray *sessionList;
	NSIndexPath *sentIndexPath;
}

@property (nonatomic, retain) NSArray *sessionList;
@property (readwrite, assign) NSIndexPath *sentIndexPath;

- (IBAction) addToMySessions:(Session *)session;
- (IBAction) removeSession:(Session *)session;

@end
