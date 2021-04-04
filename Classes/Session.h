//
//  Session.h
//  CodeMash
//
//  Created by Metehan Karabiber on 11/5/09.
//  Copyright 2009 Quick Solutions, Inc.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Speaker.h"


@interface Session : NSObject {
	NSUInteger sessionId;
	NSString *title;
	NSString *sAbstract;
	NSString *difficulty;
	
	NSString *date;
	NSString *time;
	
	Speaker *speaker;
}

@property (readwrite, assign) NSUInteger sessionId;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *sAbstract;
@property (nonatomic, retain) NSString *difficulty;

@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *time;

@property (nonatomic, retain) Speaker *speaker;

@end