//
//  ViewPower.m
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/27.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import "ViewPower.h"
#import "ClientSocket.h"
#import "Common.h"

@implementation ViewPower

-(void)LetDoIt:(NSString *)Command{
    Common *Variable=[[Common alloc]init];
    _clientsocket = [[ClientSocket alloc]init];
    [_clientsocket setSocketMessage:Command];
    [_clientsocket initNetworkCommunication:ServerIP];
}

- (IBAction)btnPCSleep:(id)sender {
     [self LetDoIt:@"MRCode_CC_00"];
}

- (IBAction)btnPCRest:(id)sender {
     [self LetDoIt:@"MRCode_CC_01"];
}

- (IBAction)btnPCSOff:(id)sender {
     [self LetDoIt:@"MRCode_CC_02"];
}

- (IBAction)btnMenu:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
