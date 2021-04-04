//
//  DataProvider.h
//  CodeMash
//
//  Created by Metehan Karabiber on 11/5/09.
//  Copyright 2009 Quick Solutions, Inc.. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataProvider : NSObject {

}

+ (NSArray *) getTechnologies;

+ (NSArray *) getLevels;

+ (NSArray *) getAllSessions;

+ (NSArray *) getPrecompilers;

+ (NSArray *) getSessionsByTechnology:(NSUInteger)technology;

+ (NSArray *) getSessionsByLevels:(NSUInteger)level;

@end
