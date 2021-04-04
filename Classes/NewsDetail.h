//
//  NewsDetail.h
//  CodeMash
//
//  Created by Metehan Karabiber on 11/10/09.
//  Copyright 2009 Quick Solutions, Inc.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Story.h"


@interface NewsDetail : UITableViewController {
	Story *story;
}

@property (nonatomic, retain) Story *story;

@end
