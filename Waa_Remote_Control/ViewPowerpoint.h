//
//  ViewPowerpoint.h
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/25.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClientSocket.h"
#import "Common.h"

@interface ViewPowerpoint : UIViewController<NSStreamDelegate>
- (IBAction)btnHome:(id)sender;
//- (IBAction)btnHelp:(id)sender;
- (IBAction)btnVolumeUp:(id)sender;
- (IBAction)btnVolumeDown:(id)sender;
- (IBAction)btnPageBack:(id)sender;
- (IBAction)btnPageNext:(id)sender;
- (IBAction)btnAction:(id)sender;
- (IBAction)btnFilelist:(id)sender;
- (IBAction)btnTimeAdd:(id)sender;
- (IBAction)btnTimeReduce:(id)sender;
- (IBAction)btnMenu:(id)sender;
@property (retain, nonatomic)ClientSocket *clientsocket;


@end
