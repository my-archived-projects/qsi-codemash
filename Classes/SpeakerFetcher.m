//
//  SpeakerFetcher.m
//  CodeMash
//
//  Created by Metehan Karabiber on 11/14/09.
//  Copyright 2009 Quick Solutions, Inc. All rights reserved.
//

#import "SpeakerFetcher.h"
#import "Constants.h"
#import "Session.h"

@implementation SpeakerFetcher
@synthesize speaker;

- (id) init {
	self = [super init];
	
	return [super loadXMLByURL:SPEAKERS_REST];
}

- (void) dealloc {
	[speaker release]; speaker = nil;

	[super dealloc];
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI  qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {			
	
	if ([elementName isEqualToString:@"Speaker"]) {
		self.speaker = [[Speaker alloc] init];
	}
	else if ([elementName isEqualToString:@"Sessions"]) {
		self.speaker.sessions = [[NSMutableArray alloc] init];
	}
	else {
		self.currentElement = [[NSMutableString alloc] init];
	}
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {     
	
	if ([elementName isEqualToString:@"Speaker"]) {
		[objects addObject:speaker];
		[speaker release];
	}
	else {
		NSString *text = [self.currentElement stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		
		if ([elementName isEqualToString:@"Id"]) {
			speaker.speakerId = text;
		}
		else if ([elementName isEqualToString:@"Name"]) {
			speaker.name = text;
		}
		else if ([elementName isEqualToString:@"Biography"]) {
			speaker.biography = text;
		}
		else if ([elementName isEqualToString:@"SessionId"]) {
			[speaker.sessions addObject:text];
		}
		
		[self.currentElement release]; self.currentElement = nil;
	}
}

@end