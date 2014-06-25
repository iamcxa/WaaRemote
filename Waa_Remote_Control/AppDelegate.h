//
//  AppDelegate.h
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/8.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "ViewModeSetection.h"
#import "ViewPowerpoint.h"


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) ViewController *viewController;
@property (strong,nonatomic) ViewModeSetection *viewModeSetection;
@property (strong,nonatomic) ViewPowerpoint *viewPowerpoint;

@end
