//
//  ViewPower.m
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/27.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import "ViewPower.h"

@implementation ViewPower

-(void)viewDidLoad{
    [sysDege setSocketTypeFilter:TYPE_CODE_POWER];
}

// 休眠
- (IBAction)btnPCSleep:(id)sender {
    [sysDege socketStartWithMessage:@"MRCode_CC_00"];
    usleep(500000);
}

// 重開機
- (IBAction)btnPCRest:(id)sender {
    [sysDege socketStartWithMessage:@"MRCode_CC_01"];
    usleep(500000);
}

// 關機
- (IBAction)btnPCSOff:(id)sender {
    [sysDege socketStartWithMessage:@"MRCode_CC_02"];
    usleep(500000);
}

// 回選單
- (IBAction)btnMenu:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 說明選單
- (IBAction)btnHelp:(id)sender {
    [self performSegueWithIdentifier:@"GotoViewHelp" sender:self];
}


@end
