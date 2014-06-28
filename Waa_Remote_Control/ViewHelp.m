//
//  ViewHelp.m
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/27.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import "ViewHelp.h"

@implementation ViewHelp


//- (void)viewDidLoad
//{
//    //[super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//    
//    
//    //[self loadRequestFromString:@"http://iosdeveloperzone.com"];
////   
////    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"help" ofType:@"htm"];
////    NSData *htmlData = [NSData dataWithContentsOfFile:filePath];
////    
//// 
////
////    if(htmlData){
////      [_webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:nil];
////        
////        NSString *path = [[NSBundle mainBundle] pathForResource:@"help.htm" ofType:nil];
////        NSURL *url = [NSURL fileURLWithPath:path];
////        NSLog(@"%@", url);
////        
////        NSData *data = [NSData dataWithContentsOfFile:path];
////        
////        [self.webView loadData:data MIMEType:@"text/html" textEncodingName:@"big5" baseURL:nil];
////        
////        NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
////        [_webView loadRequest:requestObj];
////      //  [self.view addSubview:_webView];
////           NSLog(@"help OK");
//    
////}
//    
//    //_webView=[[UIWebView alloc] initWithFrame:self.view.bounds];
//    //[self.view addSubview: _webView];
//
//    //沙盒中读取文件
//    
////    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
////    doc=[doc stringByAppendingPathComponent:@"help.htm"];
////    NSLog(@"%@",doc);
////    
////    NSURL *url=[NSURL fileURLWithPath:doc];
////    NSLog(@"%@",url);
////    NSURLRequest *request=[NSURLRequest requestWithURL:url];
////    [_webView loadRequest:request];
//}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    NSLog(@"viewWillAppear");
//        NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//       doc=[doc stringByAppendingPathComponent:@"help.htm"];
//    NSLog(@"%@",doc);
//
//       NSURL *url=[NSURL fileURLWithPath:doc];
//       NSLog(@"%@",url);
//       NSURLRequest *request=[NSURLRequest requestWithURL:url];
//        [_webView loadRequest:request];
//}

- (IBAction)btnDisconnect:(id)sender {
     [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)btnMenu:(id)sender {
      [self dismissViewControllerAnimated:YES completion:nil];
}
@end
