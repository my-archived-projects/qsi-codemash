//
//  SessionDetail.h
//  CodeMash
//
//  Created by Metehan Karabiber on 11/6/09.
//  Copyright 2009 Quick Solutions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Session.h"

@interface SessionDetail : UITableViewController <UIActionSheetDelegate> {
	Session *session;
	BOOL add;
}

@property (nonatomic, retain) Session *session;
@property (readwrite, assign) BOOL add;

- (IBAction) addToMySessions;
- (IBAction) removeSession;

@end
