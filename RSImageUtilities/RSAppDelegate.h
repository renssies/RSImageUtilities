//
//  RSAppDelegate.h
//  InnserShadow
//
//  Created by Rens Verhoeven on 16-05-13.
//  Copyright (c) 2013 Awkward. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RSViewController;

@interface RSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) RSViewController *viewController;

@end
