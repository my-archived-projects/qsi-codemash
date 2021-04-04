//
//  SpeakerFetcher.h
//  CodeMash
//
//  Created by Metehan Karabiber on 11/14/09.
//  Copyright 2009 Quick Solutions, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fetcher.h"
#import "Speaker.h"

@interface SpeakerFetcher : Fetcher {
	Speaker *speaker;
}

@property (nonatomic, retain) Speaker *speaker;

@end