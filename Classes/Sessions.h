//
//  Sessions.h
//  CodeMash
//
//  Created by Metehan Karabiber on 11/4/09.
//  Copyright 2009 Quick Solutions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTVC.h"

@interface Sessions : CustomTVC {
	NSArray *levels;
}

@property (nonatomic, retain) NSArray *levels;

@end