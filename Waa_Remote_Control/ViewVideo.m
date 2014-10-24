//
//  ViewVideo.m
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/27.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import "ViewVideo.h"
#import "AppDelegate.h"

@implementation ViewVideo

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"@ViewVideo didLoad");
    
    
}

// 送出訊息時強制設定檔案篩選類型, 確保一定會是對應類型檔案
-(void)socketStartWithFilterType:(NSString *)Msg{
    
    if ([[sysDege selectedFileList]objectAtIndex:[sysDege selectedFileRow]]!=nil) {
        [sysDege setSocketTypeFilter:TYPE_CODE_VIDEO];
        [sysDege socketStartWithMessage:Msg];
        
    } else{
        
        [sysDege showAlert:@"請先選擇檔案！"];
        
    }
}

// 說明選單
- (IBAction)btnHelp:(id)sender {
    [self performSegueWithIdentifier:@"GotoViewHelp" sender:self];
}

// 檔案清單
- (IBAction)btnFilelist:(id)sender {
    [sysDege setSocketTypeFilter:TYPE_CODE_VIDEO_TO_FILE_LIST];
    [sysDege socketStartWithMessage:[sysDege MRCode_Show_Videos]];
}

// 主選單
- (IBAction)btnMenu:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnItemLast:(id)sender {
    [self socketStartWithFilterType:@"MRCode_WMP_12"];
    usleep(200000);
}

- (IBAction)btnItemNext:(id)sender {
    [self socketStartWithFilterType:@"MRCode_WMP_13"];
    usleep(200000);
}


- (IBAction)btnPlayFaster:(id)sender {
    [self socketStartWithFilterType:@"MRCode_WMP_17"];
    usleep(200000);
}

- (IBAction)btnPlaySlower:(id)sender {
    [self socketStartWithFilterType:@"MRCode_WMP_18"];
    usleep(200000);
}

- (IBAction)BtnStop:(id)sender {
    [self socketStartWithFilterType:@"MRCode_WMP_19"];
    usleep(200000);
}

- (IBAction)btnPlay:(id)sender {
    [self socketStartWithFilterType:@"MRCode_WMP_10"];
    usleep(200000);
}

- (IBAction)btnMute:(id)sender {
    [self socketStartWithFilterType:@"MRCode_WMP_14"];
    usleep(200000);
}

- (IBAction)btnVolumeDown:(id)sender {
    [self socketStartWithFilterType:@"MRCode_WMP_16"];
    usleep(200000);
}

- (IBAction)btnVolumeUp:(id)sender {
    [self socketStartWithFilterType:@"MRCode_WMP_15"];
    usleep(200000);
}


- (IBAction)btnFullScreen:(id)sender {
    [self socketStartWithFilterType:@"MRCode_WMP_11"];
    usleep(200000);
}

- (IBAction)btnPlayRepeat:(id)sender {
    [self socketStartWithFilterType:@"MRCode_WMP_02"];
    usleep(200000);
}

- (IBAction)btnPlayRandom:(id)sender {
    [self socketStartWithFilterType:@"MRCode_WMP_01"];
    usleep(200000);
}

- (IBAction)btnTurnOffPlayer:(id)sender {
    [self socketStartWithFilterType:@"MRCode_WMP_00"];
    usleep(200000);
}

-(void)viewDidDisappear:(BOOL)animated{
    [sysDege setLastTimeUsedCmd:nil];
    [sysDege setSelectedFileList:nil];
    [sysDege setSelectedFileRow:0];
}
@end
