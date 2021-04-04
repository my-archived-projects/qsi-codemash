//
//  Story.h
//  CodeMash
//
//  Created by Metehan Karabiber on 11/10/09.
//  Copyright 2009 Quick Solutions, Inc.. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Story : NSObject {
	NSString *title;
	NSString *summary;
	NSString *date;
}

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *summary;
@property (nonatomic, retain) NSString *date;

@end
