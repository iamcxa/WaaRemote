//
//  Common.m
//  Waa_Remote_Control
//
//  Created by FuD on 2014/6/28.
//  Copyright (c) 2014年 FuD. All rights reserved.
//

#import "Common.h"
#import "ClientSocket.h"

@implementation Common
@synthesize ServerIP;

NSString *thisMsg=nil;

-(void)ServerCommunication{
    
    _CommonSocket = [[ClientSocket alloc]init];
    [_CommonSocket setSocketMessage:thisMsg];
    NSLog(@"before init");
    [_CommonSocket initNetworkCommunication:ServerIP];
    NSLog(@"after init");
}

-(void) setThisMessage:(NSString *)thisMessage{
    thisMsg=[thisMessage stringByAppendingString:@"\n"];
}

@end
