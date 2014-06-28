//
//  ViewSelect.h
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/8.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClientSocket.h"
#import "Common.h"

@interface ViewSelect : UIViewController<NSStreamDelegate>
- (IBAction)btnDisconnect:(id)sender;
- (IBAction)btnPowerPoint:(id)sender;
- (IBAction)btnHelp:(id)sender;
- (IBAction)btnMovie:(id)sender;
- (IBAction)btnMusic:(id)sender;

@property (retain, nonatomic)ClientSocket *clientsocket;

@end
