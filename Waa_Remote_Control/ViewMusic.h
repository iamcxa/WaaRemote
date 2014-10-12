//
//  ViewMusic.h
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/27.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewMusic : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *labelSocketMsg;
- (IBAction)btnStartOrEndPlayer:(id)sender;
- (IBAction)btnHelp:(id)sender;
- (IBAction)btnMenu:(id)sender;
- (IBAction)btnNext:(id)sender;
- (IBAction)btnBack:(id)sender;
- (IBAction)btnStop:(id)sender;
- (IBAction)btnPlayOrPause:(id)sender;
- (IBAction)btnMute:(id)sender;
- (IBAction)bntVolumeLower:(id)sender;
- (IBAction)btnVolumeBigger:(id)sender;
- (IBAction)btnFileList:(id)sender;



@end
