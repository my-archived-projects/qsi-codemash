//
//  MySessions.m
//  CodeMash
//
//  Created by Metehan Karabiber on 11/4/09.
//  Copyright 2009 Quick Solutions, Inc. All rights reserved.
//

#import "MySessions.h"
#import "Session.h"
#import "SessionDetail.h"
#import "CodeMashDAO.h"


@implementation MySessions

@synthesize sessionList;

- (void)viewDidLoad {
	[super viewDidLoad];

	self.navigationItem.rightBarButtonItem = self.editButtonItem;
	self.title = @"My Sessions";

	sessionList = [[CodeMashDAO getMySessions] retain];
}

#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [sessionList count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   static NSString *CellIdentifier = @"MySessionsCell";
   
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
   if (cell == nil) {
       cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
   }

	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

	if (self.sessionList) {
		Session *session = (Session *) [sessionList objectAtIndex:indexPath.row];
		
		cell.textLabel.font = [UIFont fontWithName:@"Arial" size:13.0];
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.text = session.title;
	}

   return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 60.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	Session *session = (Session *) [sessionList objectAtIndex:indexPath.row];
	
	SessionDetail *sessionDetail = [[SessionDetail alloc] initWithStyle:UITableViewStylePlain];
	sessionDetail.session = session;
	sessionDetail.add = NO;
	
	[self.navigationController pushViewController:sessionDetail animated:YES];
	[sessionDetail release];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)dealloc {
	[sessionList release]; self.sessionList = nil;
   [super dealloc];
}


@end

