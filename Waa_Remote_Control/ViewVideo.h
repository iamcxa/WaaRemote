//
//  ViewVideo.h
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/27.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewVideo : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *labelSocketMsg;
- (IBAction)btnHelp:(id)sender;
- (IBAction)btnMenu:(id)sender;
- (IBAction)btnItemNext:(id)sender;
- (IBAction)btnItemLast:(id)sender;
- (IBAction)btnPlayFaster:(id)sender;
- (IBAction)btnPlaySlower:(id)sender;
- (IBAction)BtnStop:(id)sender;
- (IBAction)btnPlay:(id)sender;
- (IBAction)btnMute:(id)sender;
- (IBAction)btnVolumeDown:(id)sender;
- (IBAction)btnVolumeUp:(id)sender;
- (IBAction)btnFilelist:(id)sender;
- (IBAction)btnFullScreen:(id)sender;
- (IBAction)btnPlayRepeat:(id)sender;
- (IBAction)btnPlayRandom:(id)sender;
- (IBAction)btnStartOrEnd:(id)sender;
- (IBAction)btnTurnOffPlayer:(id)sender;

-(void)setSocketMsg:(NSString *)Message;

@end
