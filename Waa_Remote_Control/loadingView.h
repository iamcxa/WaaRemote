//
//  loadingView.h
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/10/12.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface loadingView : UIViewController{
    UIActivityIndicatorView *activityView;
    UIView *loadingView;
    UILabel *loadingLabel;
}

@property (nonatomic, retain) UIActivityIndicatorView * activityView;
@property (nonatomic, retain) UIView *loadingView;
@property (nonatomic, retain) UILabel *loadingLabel;


@end
