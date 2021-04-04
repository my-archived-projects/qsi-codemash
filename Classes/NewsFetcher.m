//
//  NewsFetcher.m
//  CodeMash
//
//  Created by Metehan Karabiber on 11/14/09.
//  Copyright 2009 Quick Solutions, Inc. All rights reserved.
//

#import "NewsFetcher.h"
#import "Constants.h"

@implementation NewsFetcher
@synthesize story;

- (id) init {
	self = [super init];

	return [super loadXMLByURL:NEWS_FEED];
}

- (void) dealloc {
	[story release]; story = nil;
	[super dealloc];
}

- (void) parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI  qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {			
	
	if ([elementName isEqualToString:@"item"]) {
		self.story = [[Story alloc] init];
	}
	else {
		self.currentElement = [[NSMutableString alloc] init];
	}
}

- (void) parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {     
	
	if ([elementName isEqualToString:@"item"]) {
		[self.objects addObject:self.story];
		[self.story release];
	}
	else {
		NSString *text = [self.currentElement stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
		
		if ([elementName isEqualToString:@"title"]) {
			self.story.title = text;
		}
		else if ([elementName isEqualToString:@"description"]) {
			self.story.summary = text;
		}
		else if ([elementName isEqualToString:@"a10:updated"]) {
			self.story.date = [[text componentsSeparatedByString:@"T"] objectAtIndex:0];
		}
		
		[self.currentElement release]; self.currentElement = nil;
	}
}

@end