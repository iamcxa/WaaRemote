//
//  ViewHelp.h
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/27.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewHelp :UIViewController
- (IBAction)btnDisconnect:(id)sender;
- (IBAction)btnMenu:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView;


@end
