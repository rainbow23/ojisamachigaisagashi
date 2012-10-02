//
//  AppDelegate.h
//  TheFakeShow
//
//  Created by Masato Fukano on 11/08/09.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow * window;

@property (nonatomic, retain) IBOutlet MainViewController * mainViewController;

@end
