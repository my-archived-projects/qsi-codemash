//
//  CodeMashDAO.m
//  CodeMash
//
//  Created by Metehan Karabiber on 11/6/09.
//  Copyright 2009 Quick Solutions, Inc.. All rights reserved.
//

#import "CodeMashDAO.h"
#import "FMDatabase.h"

#define DATABASE @"codemash.sqlite"

@implementation CodeMashDAO

+ (BOOL) insertSession:(Session *)session {
	
	NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *path = [docs stringByAppendingPathComponent:DATABASE];

	FMDatabase* db = [FMDatabase databaseWithPath:path];
	if (![db open]) {
		NSLog(@"Could not open db.");
		return NO;
	}

	NSString *sql = @"INSERT INTO mysessions VALUES(?,?,?,?,?,?,?)";
	
	[db beginTransaction];
	BOOL success = [db executeUpdate:sql, 
												session.sessionId,
												session.title,
												session.sAbstract,
												session.difficulty,
												session.date,
												session.time
						];	
	[db commit];
	[db close];
	
	return success;
}

+ (BOOL) insertSessions:(NSArray *)sessions {
	
	return YES;
}

+ (BOOL) insertSpeakers:(NSArray *)speakers {

	
	return YES;
}

+ (BOOL) sessionAlreadyAdded:(Session *)session {
	
	
	return NO;
}

+ (BOOL) removeSession:(Session *)session {
	
	
	return YES;
}

+ (NSArray *) getMySessions {

	NSString *docs = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
	NSString *path = [docs stringByAppendingPathComponent:DATABASE];
	
	FMDatabase* db = [FMDatabase databaseWithPath:path];
	if (![db open]) {
		NSLog(@"Could not open db.");
		return NO;
	}
	
	FMResultSet *rs = [db executeQuery:@"SELECT * FROM mysessions ORDER BY day ASC, startTime ASC"];
	NSMutableArray *sessions = [[NSMutableArray alloc] init];
	
	while ([rs next]) {
		Session *session		= [[Session alloc] init];
		session.sessionId		= [rs intForColumn:@"sessionId"];
		session.title			= [rs stringForColumn:@"title"];
		session.sAbstract		= [rs stringForColumn:@"abstract"];
		session.difficulty	= [rs stringForColumn:@"difficulty"];
		session.date			= [rs stringForColumn:@"day"];
		session.time			= [rs stringForColumn:@"time"];
		[sessions addObject:session];
		[session release];
	}
	
	[rs close];
	[db close];
	
	return [sessions autorelease];
}

@end
