//
//  ViewScanIP.h
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/8.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewScanIP;

@interface ViewScanIP : UIViewController<NSStreamDelegate>
@property (weak, nonatomic) IBOutlet UILabel *labelSocketMsg;

@property (weak, nonatomic) IBOutlet UILabel *LabelServerIP;
@property (weak, nonatomic) IBOutlet UITextField *textboxServerIp;
@property (weak, nonatomic) IBOutlet UILabel *message;

-(IBAction)btnConnect:(id)sender;

-(void)setSocketMsg:(NSString *)Message;
@end
