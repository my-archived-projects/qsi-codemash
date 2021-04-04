//
//  Session.m
//  CodeMash
//
//  Created by Metehan Karabiber on 11/5/09.
//  Copyright 2009 Quick Solutions, Inc.. All rights reserved.
//

#import "Session.h"

@implementation Session

@synthesize sessionId, title, sAbstract, difficulty;
@synthesize date, time;
@synthesize speaker;

- (void) dealloc {
	[title release];		title = nil;
	[sAbstract release];	sAbstract = nil;
	[difficulty release];difficulty = nil;

	[date	release]; date = nil;
	[time release]; time	= nil;

	[speaker release]; speaker = nil;
	
	[super dealloc];
}

@end