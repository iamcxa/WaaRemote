//
//  MainViewController.h
//  csu.waaremote
//
//  Created by iamcxa on 2014/8/20.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate, UIPopoverControllerDelegate>

@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;

@end
