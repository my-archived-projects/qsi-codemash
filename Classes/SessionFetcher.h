//
//  SessionFetcher.h
//  CodeMash
//
//  Created by Metehan Karabiber on 11/14/09.
//  Copyright 2009 Quick Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fetcher.h"
#import "Session.h"


@interface SessionFetcher : Fetcher {
	Session *session;
}

@property (nonatomic, retain) Session *session;

@end
