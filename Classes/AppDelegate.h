//
//  CodeMashAppDelegate.h
//  CodeMash
//
//  Created by Metehan Karabiber on 11/3/09.
//  Copyright 2009 Quick Solutions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
   UIWindow *window;
   UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;


@end
