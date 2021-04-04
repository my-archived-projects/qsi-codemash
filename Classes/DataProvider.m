//
//  DataProvider.m
//  CodeMash
//
//  Created by Metehan Karabiber on 11/5/09.
//  Copyright 2009 Quick Solutions, Inc.. All rights reserved.
//

#import "DataProvider.h"
#import "Session.h"


@implementation DataProvider

+ (NSArray *) getTechnologies {
	return [NSArray arrayWithObjects:@".NET", @"Java", @"Ruby", @"Python", @"Other", @"Other Languages", nil];
}

+ (NSArray *) getLevels {
	return [NSArray arrayWithObjects:@"Beginner", @"Intermediate", @"Advanced", nil];
}

+ (NSArray *) getAllSessions {

	NSMutableArray *sessions = [[NSMutableArray alloc] init];
	
	Session *session = [[Session alloc] init];
	session.title = @"Getting Snakes on Your Monday-to-Friday Plane: Strategies for Python Evangelism and Adoption";
	session.sAbstract = @"This is a trial desc. This is a trial desc. This is a trial desc. This is a trial desc. This is a trial desc. This is a trial desc. ";
/*	session.sessionDesc = [session.sessionDesc stringByAppendingString:session.sessionDesc];
	session.sessionDesc = [session.sessionDesc stringByAppendingString:session.sessionDesc];
	session.sessionPlatform = @"Python";
	session.sessionLevel = @"Beginner";
	session.sessionDate = @"01/17/2010";
	session.sessionStart = @"10:00";
	session.sessionEnd = @"12:00"; */
	[sessions addObject:session];
	[session release];

	session = [[Session alloc] init];
	session.title = @"Trial 2";
	[sessions addObject:session];
	[session release];

	session = [[Session alloc] init];
	session.title = @"Trial 3";
	[sessions addObject:session];
	[session release];
	
	return [sessions autorelease];
}

+ (NSArray *) getPrecompilers {
	
	NSMutableArray *sessions = [[NSMutableArray alloc] init];
	
	Session *session = [[Session alloc] init];
	session.title = @"Modular Java Using OSGi with Todd Kaufman";
	session.sAbstract = @"This is a trial desc. This is a trial desc. This is a trial desc. This is a trial desc. This is a trial desc. This is a trial desc. ";
/*	session.sessionDesc = [session.sessionDesc stringByAppendingString:session.sessionDesc];
	session.sessionDesc = [session.sessionDesc stringByAppendingString:session.sessionDesc];
	session.sessionDesc = [session.sessionDesc stringByAppendingString:session.sessionDesc];
	session.sessionPlatform = @"Java";
	session.sessionLevel = @"200/300";
	session.sessionDate = @"01/17/2010";
	session.sessionStart = @"10:00";
	session.sessionEnd = @"12:00"; */
	[sessions addObject:session];
	[session release];
	
	session = [[Session alloc] init];
	session.title = @"Test Driven Development: From Concept to Deployment with Leon Gersing (all day)";
	[sessions addObject:session];
	[session release];
	
	session = [[Session alloc] init];
	session.title = @"Software Engineering Fundamentals Workshop: OOP, SOLID, and More with Jon Kruger";
	[sessions addObject:session];
	[session release];
	
	return [sessions autorelease];}

+ (NSArray *) getSessionsByTechnology:(NSUInteger)technology {
	NSMutableArray *sessions = [[NSMutableArray alloc] init];
	
	Session *session = [[Session alloc] init];
	session.title = @"Java 1";
	[sessions addObject:session];
	[session release];
	
	session = [[Session alloc] init];
	session.title = @"Java 2";
	[sessions addObject:session];
	[session release];
	
	session = [[Session alloc] init];
	session.title = @"Java 3";
	[sessions addObject:session];
	[session release];
	
	return [sessions autorelease];
}

+ (NSArray *) getSessionsByLevels:(NSUInteger)level {
	NSMutableArray *sessions = [[NSMutableArray alloc] init];
	
	Session *session = [[Session alloc] init];
	session.title = @"Beginner 1";
	[sessions addObject:session];
	[session release];
	
	session = [[Session alloc] init];
	session.title = @"Beginner 2";
	[sessions addObject:session];
	[session release];
	
	session = [[Session alloc] init];
	session.title = @"Beginner 3";
	[sessions addObject:session];
	[session release];
	
	return [sessions autorelease];
}


@end
