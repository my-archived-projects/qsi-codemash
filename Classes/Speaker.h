//
//  Speaker.h
//  CodeMash
//
//  Created by Metehan Karabiber on 11/14/09.
//  Copyright 2009 Quick Solutions, Inc.. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Speaker : NSObject {

	NSString *speakerId;
	NSString *name;
	NSString *biography;

	NSMutableArray *sessions;
}

@property (nonatomic, retain) NSString *speakerId;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *biography;
@property (nonatomic, retain) NSMutableArray *sessions;


@end
