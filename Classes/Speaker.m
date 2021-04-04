//
//  Speaker.m
//  CodeMash
//
//  Created by Metehan Karabiber on 11/14/09.
//  Copyright 2009 Quick Solutions, Inc.. All rights reserved.
//

#import "Speaker.h"


@implementation Speaker

@synthesize speakerId;
@synthesize name;
@synthesize biography;
@synthesize sessions;

- (void)dealloc {
	[speakerId release];	speakerId = nil;
	[name release];		name = nil;
	[biography release]; biography = nil;
	[sessions release];	sessions = nil;

	[super dealloc];
}


@end
