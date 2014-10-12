////
////  loadingView.m
////  Waa_Remote_Control
////
////  Created by iamcxa on 2014/10/12.
////  Copyright (c) 2014年 iamcxa. All rights reserved.
////
//
//#import "QuartzCore/QuartzCore.h"
//#import "loadingView.h"
//
//@implementation loadingView;
//
//
//-(void)loadingStop{
//    
//    NSLog(@"\n@subviews=%@",[self.navigator.view subviews]);
//    
//    [activityView stopAnimating];
//    [loadingView removeFromSuperview];
//    
//    for(UIView *subview in [[sysDege window] subviews]){
//        // remove the subview with tag equal to "9099"
//        if(subview.tag == 90999){
//            [subview removeFromSuperview];
//            NSLog(@"subview =%@",subview);
//        }
//    }
//    
//    
//}
//
//-(UIView *)loadingView{
//    self.loadingView.tag=90999;
//    self.loadingView = [[UIView alloc] initWithFrame:CGRectMake(75, 155, 170, 170)];
//    self.loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//    self.loadingView.clipsToBounds = YES;
//    self.loadingView.layer.cornerRadius = 10.0;
//    
//    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
//    activityView.frame = CGRectMake(65, 40, activityView.bounds.size.width, activityView.bounds.size.height);
//    [loadingView addSubview:activityView];
//    
//    loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 115, 130, 22)];
//    loadingLabel.backgroundColor = [UIColor clearColor];
//    loadingLabel.textColor = [UIColor whiteColor];
//    loadingLabel.adjustsFontSizeToFitWidth = YES;
//    loadingLabel.textAlignment = UITextAlignmentCenter;
//    loadingLabel.text = @"Loading...";
//    [loadingView addSubview:loadingLabel];
//    
//    [[sysDege window] addSubview:loadingView];
//    
//    [activityView startAnimating];
//    
//    return loadingView;
//}
//
//@end
