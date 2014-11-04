//
//  ViewScanIP.m
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/8.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//
#import "ViewScanIP.h"
#import "toast.h"

@interface ViewScanIP ()

@end


@implementation ViewScanIP

@synthesize labelMessage;

- (void)viewDidLoad
{
    [super viewDidLoad];  NSLog(@"@IPScaner didLoad");
    
    labelMessage.alpha=1; labelMessage.text=@"請輸入ＩＰ";
    
    if ([sysDege lastTimeUsedServerIP]!=nil){
        self.textboxServerIp.text=[sysDege lastTimeUsedServerIP];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
    // 清空變數
    [sysDege setLastTimeSocketInputMsg:@""];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnConnect:(id)sender
{
    NSString *serverIP=self.textboxServerIp.text;
    NSLog(@"@inputIP=%@",serverIP);
    
    if([sysDege checkServerIpFormat:serverIP]){
        
        NSLog(@"@IPScaner's going to sned this:'%@'",[sysDege MRCode_Connect]);
        
        [sysDege setServerIP:serverIP];
        [sysDege setSocketTypeFilter:TYPE_CODE_FIND_IP];
        [sysDege socketStartWithMessage:[sysDege MRCode_Connect]];
    }
}

- (IBAction)textboxServerIp:(id)sender {
    
}


-(void)setSocketMsg:(NSString *)Message{
    _labelSocketMsg.text=Message;
}




@end
