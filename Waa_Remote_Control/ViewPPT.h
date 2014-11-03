//
//  ViewPowerpoint.h
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/25.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface ViewPPT : UIViewController

@property (nonatomic,retain) UIStoryboard *board;
@property (retain, nonatomic) IBOutlet UILabel *txtFileSelectedNowName;
@property (weak, nonatomic) IBOutlet UIImageView *signRed;
@property (weak, nonatomic) IBOutlet UIImageView *signYellow;
@property (weak, nonatomic) IBOutlet UILabel *labelTimeCounterMins;
@property (weak, nonatomic) IBOutlet UILabel *labelTimeCounterSecs;

- (IBAction)btnHelp:(id)sender;
- (IBAction)btnVolumeUp:(id)sender;
- (IBAction)btnVolumeDown:(id)sender;
- (IBAction)btnPageBack:(id)sender;
- (IBAction)btnPageNext:(id)sender;
- (IBAction)btnAction:(id)sender;
- (IBAction)btnFilelist:(id)sender;
- (IBAction)btnTimeCounterAdd:(id)sender;
- (IBAction)btnTimeCounterReduce:(id)sender;
@end
