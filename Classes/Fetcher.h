//
//  Fetcher.h
//  CodeMash
//
//  Created by Metehan Karabiber on 11/14/09.
//  Copyright 2009 Quick Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Fetcher : NSObject {
	
	NSMutableArray *objects;
	NSXMLParser *xmlParser;
	NSMutableString *currentElement;
}

@property (nonatomic, retain) NSMutableArray *objects;
@property (nonatomic, retain) NSXMLParser *xmlParser;
@property (nonatomic, retain) NSMutableString *currentElement;

- (id) loadXMLByURL:(NSString *)urlString;

@end