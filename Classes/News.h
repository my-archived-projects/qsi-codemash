//
//  News.h
//  CodeMash
//
//  Created by Metehan Karabiber on 11/10/09.
//  Copyright 2009 Quick Solutions, Inc.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTVC.h"
#import "Story.h"

@interface News : CustomTVC {
	NSArray *stories;
}

@property (nonatomic, retain) NSArray * stories;

@end