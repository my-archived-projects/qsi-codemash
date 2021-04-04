//
//  Fetcher.m
//  CodeMash
//
//  Created by Metehan Karabiber on 11/14/09.
//  Copyright 2009 Quick Solutions, Inc. All rights reserved.
//

#import "Fetcher.h"

@implementation Fetcher
@synthesize xmlParser, currentElement, objects;

- (id) loadXMLByURL:(NSString *)urlString {
	self.objects = [[NSMutableArray alloc] init];

	xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString: urlString]];
	xmlParser.delegate = self;
	[xmlParser parse];

	return self;
}

- (void) dealloc {
	[xmlParser release]; xmlParser = nil;
	[currentElement release]; currentElement = nil;
	[objects release]; objects = nil;
	[super dealloc];
}

- (void) parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
	[self.currentElement appendString:[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
}

- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Unable to download feed from web site (Error code %i )", [parseError code]];
	
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
	[errorAlert release];
}

@end