//
//  SessionFetcher.m
//  CodeMash
//
//  Created by Metehan Karabiber on 11/14/09.
//  Copyright 2009 Quick Solutions, Inc. All rights reserved.
//

#import "SessionFetcher.h"
#import "Constants.h"
#import "Speaker.h"

@implementation SessionFetcher
@synthesize session;

- (id) init {
	self = [super init];
	
	return [super loadXMLByURL:SESSIONS_REST];
}

- (void) dealloc {
	[session release]; session = nil;
	[super dealloc];
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI  qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {			
	
	if ([elementName isEqualToString:@"Session"]) {
		self.session = [[Session alloc] init];
	}
	else {
		self.currentElement = [[NSMutableString alloc] init];
	}
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {     
	
	if ([elementName isEqualToString:@"Session"]) {
		[objects addObject:self.session];
		[session release];
	}
	else {
		NSString *text = [self.currentElement stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		
		if ([elementName isEqualToString:@"Id"]) {
			session.sessionId = [text intValue];
		}
		else if ([elementName isEqualToString:@"Title"]) {
			session.title = text;
		}
		else if ([elementName isEqualToString:@"Abstract"]) {
			session.sAbstract = text;
		}
		else if ([elementName isEqualToString:@"Start"]) {
			NSArray *timestamp = [text componentsSeparatedByString:@"T"];

			session.date = [timestamp objectAtIndex:0];
			session.time = [[timestamp objectAtIndex:1] substringToIndex:5];
		}
		else if ([elementName isEqualToString:@"Difficulty"]) {
			session.difficulty = text;
		}
		else if ([elementName isEqualToString:@"SpeakerName"]) {
			if (session.speaker) {
				session.speaker.name = text;
			}
			else {
				Speaker* speaker = [[Speaker alloc] init];
				session.speaker = [speaker retain];
				[speaker release];

				session.speaker.name = text;
			}
		}
		else if ([elementName isEqualToString:@"SpeakerId"]) {
			if (session.speaker) {
				session.speaker.speakerId = text;
			}
			else {
				Speaker* speaker = [[Speaker alloc] init];
				session.speaker = [speaker retain];
				[speaker release];
				
				session.speaker.speakerId = text;
			}
		}
		
		[self.currentElement release]; self.currentElement = nil;
	}
}

@end
