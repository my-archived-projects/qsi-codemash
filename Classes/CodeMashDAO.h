//
//  CodeMashDAO.h
//  CodeMash
//
//  Created by Metehan Karabiber on 11/6/09.
//  Copyright 2009 Quick Solutions, Inc.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Session.h"

@interface CodeMashDAO : NSObject {
}

+ (BOOL) insertSession:(Session *)session;

+ (BOOL) insertSessions:(NSArray *)sessions;

+ (BOOL) insertSpeakers:(NSArray *)speakers;

+ (BOOL) sessionAlreadyAdded:(Session *)session;

+ (BOOL) removeSession:(Session *)session;

+ (NSArray *) getMySessions;

@end
