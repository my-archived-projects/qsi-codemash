//
//  Util.m
//  CodeMash
//
//  Created by Metehan Karabiber on 11/11/09.
//  Copyright 2009 Quick Solutions, Inc.. All rights reserved.
//

#import "Util.h"

@implementation Util

+ (CGFloat) getHeightWithText:(NSString *)text withFont:(UIFont *)font withWidth:(CGFloat)width {

	CGSize constraint = CGSizeMake(width, CGFLOAT_MAX);

	CGSize size = [text sizeWithFont:font constrainedToSize:constraint];

	return size.height;
}

@end