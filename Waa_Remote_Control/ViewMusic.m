//
//  ViewMusic.m
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/27.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import "ViewMusic.h"

@implementation ViewMusic
- (IBAction)btnMenu:(id)sender {
      [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnNext:(id)sender {
    usleep(200000);
}

- (IBAction)btnBack:(id)sender {
    usleep(200000);
}

- (IBAction)btnStop:(id)sender {
    usleep(200000);
}

- (IBAction)btnPlayOrPause:(id)sender {
    usleep(200000);
}

- (IBAction)btnStartOrEndPlayer:(id)sender {
    usleep(200000);
}

- (IBAction)btnMute:(id)sender {
    usleep(200000);
}

- (IBAction)bntVolumeLower:(id)sender {
    usleep(200000);
}

- (IBAction)btnVolumeBigger:(id)sender {
    usleep(200000);
}

// 說明選單
- (IBAction)btnHelp:(id)sender {
    [self performSegueWithIdentifier:@"GotoViewHelp" sender:self];
}

// 檔案清單
- (IBAction)btnFileList:(id)sender {
    [sysDege setSocketTypeFilter:TYPE_CODE_MUSIC_TO_FILE_LIST];
    [sysDege socketStartWithMessage:[sysDege MRCode_Show_Music]];
}

-(void)viewDidDisappear:(BOOL)animated{
    [sysDege setLastTimeUsedCmd:nil];
    [sysDege setFileSelectedList:nil];
    [sysDege setFileSelectedRow:0];
}
@end
