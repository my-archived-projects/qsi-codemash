//
//  Story.m
//  CodeMash
//
//  Created by Metehan Karabiber on 11/10/09.
//  Copyright 2009 Quick Solutions, Inc.. All rights reserved.
//

#import "Story.h"

@implementation Story

@synthesize title, summary, date;

- (void) dealloc {
	[title release]; title = nil;
	[summary release]; summary = nil;
	[date release]; date = nil;

	[super dealloc];
}

- (NSString *)description {
	return [NSString stringWithFormat:@"Title:%@\nSummary:%@\nDate:%@", self.title, self.summary, self.date];
	
}

@end
