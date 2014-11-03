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
    
    UIWebView *webView;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    // NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    //[webView loadRequest:request];
    
    
    // [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"help" ofType:@"htm"]isDirectory:@""]]];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"help" withExtension:@"htm"];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
    // Load the html as a string from the file system
    //    NSString *path = [[NSBundle mainBundle] pathForResource:@"help" ofType:@"htm"];
    //      NSString *html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //    [webView loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
    
    [self.view addSubview: webView];
    
}



- (IBAction)btnMenu:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
