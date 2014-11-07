//
//  ViewHelp.m
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/27.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import "ViewHelp.h"
#import "ViewSwitchController.h"


@implementation ViewHelp{
    
    //UIWebView *webView;
}

@synthesize webView;
@synthesize defaultURL;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    defaultURL=@"http://fuyaode.github.io/RemoteHelp";
    

    
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:defaultURL]];
    
    [webView loadRequest:request];
    
    [self.view addSubview: webView];
    
}



- (IBAction)btnMenu:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
