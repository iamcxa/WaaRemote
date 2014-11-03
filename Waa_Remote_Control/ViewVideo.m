//
//  ViewVideo.m
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/27.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import "ViewVideo.h"
#import "toast.h"

@implementation ViewVideo{
    
    int statusPlay;
    int statusMute;
    int statusRandPly;
    int statusReptPly;
    int statusFulScr;
}

- (void)viewDidLoad
{
    [super viewDidLoad];  NSLog(@"@ViewVideo didLoad");
    
    // 設定狀態旗標
    statusPlay=0; statusMute=0;
    statusRandPly=0; statusReptPly=0;
    statusFulScr=0;
}

// 送出訊息時強制設定檔案篩選類型, 確保一定會是對應類型檔案
-(BOOL)socketStartWithFilterType:(NSString *)Msg{
    
    if ([[sysDege selectedFileList]objectAtIndex:[sysDege selectedFileRow]]!=nil) {
        [sysDege setSocketTypeFilter:TYPE_CODE_VIDEO];
        [sysDege socketStartWithMessage:Msg];
        
        return YES;
        
    } else{
        
        [self toast:@"請先選擇檔案！"];
        [self btnFilelist:self];
        return NO;
    }
}

// 說明選單
- (IBAction)btnHelp:(id)sender {
    
    [[sysDege viewSwitchController]showViewHelp];
}

// 檔案清單
- (IBAction)btnFilelist:(id)sender {
    
    [sysDege setSocketTypeFilter:TYPE_CODE_VIDEO_TO_FILE_LIST];
    [sysDege socketStartWithMessage:[sysDege MRCode_Show_Videos]];
}

- (IBAction)btnItemLast:(id)sender {
    
    [self socketStartWithFilterType:@"MRCode_WMP_12"];
    [self toast:@"上一個"]; usleep(200000);
}

- (IBAction)btnItemNext:(id)sender {
    
    [self socketStartWithFilterType:@"MRCode_WMP_13"];
    [self toast:@"下一個"]; usleep(200000);
}


- (IBAction)btnPlayFaster:(id)sender {
    
    [self socketStartWithFilterType:@"MRCode_WMP_17"];
    [self toast:@"播放：快轉"]; usleep(200000);
}

- (IBAction)btnPlaySlower:(id)sender {
    
    [self socketStartWithFilterType:@"MRCode_WMP_18"];
    [self toast:@"播放：減速"]; usleep(200000);
}

// 停止
- (IBAction)BtnStop:(id)sender {
    
    [self socketStartWithFilterType:@"MRCode_WMP_19"];
    [self toast:@"停止"]; usleep(200000);
}

// 播放/暫停
- (IBAction)btnPlay:(id)sender {
    
    if([self socketStartWithFilterType:@"MRCode_WMP_10"]){
        if (statusPlay==0){
            
            statusPlay=1; [self toast:@"播放"];
            
        }else if(statusPlay==1){
            
            statusPlay=0; [self toast:@"暫停"];
        }
    }
    usleep(200000);
}

// 靜音
- (IBAction)btnMute:(id)sender {
    
    if([self socketStartWithFilterType:@"MRCode_WMP_14"]){
        if (statusMute==0){
            
            statusMute=1; [self toast:@"靜音：開"];
            
        }else if(statusMute==1){
            
            statusMute=0; [self toast:@"靜音：關"];
        }
    }
    usleep(200000);
}

- (IBAction)btnVolumeDown:(id)sender {
    
    [self socketStartWithFilterType:@"MRCode_WMP_16"];
    [self toast:@"降低音量"]; usleep(200000);
}

- (IBAction)btnVolumeUp:(id)sender {
    
    [self socketStartWithFilterType:@"MRCode_WMP_15"];
    [self toast:@"提高音量"]; usleep(200000);
}

// 全螢幕
- (IBAction)btnFullScreen:(id)sender {
    
    if([self socketStartWithFilterType:@"MRCode_WMP_11"]){
        if (statusFulScr==0){
            
            statusFulScr=1; [self toast:@"全螢幕：開"];
            
        }else if (statusFulScr==1) {
            
            statusFulScr=0; [self toast:@"全螢幕：關"];
        }
    }
     usleep(200000);
}

// 重複播放
- (IBAction)btnPlayRepeat:(id)sender {
    
    if([self socketStartWithFilterType:@"MRCode_WMP_02"]){
        if (statusReptPly==0){
            
            statusReptPly=1; [self toast:@"重複播放：開"];
            
        }else if (statusReptPly==1) {
            
            statusReptPly=0; [self toast:@"重複播放：關"];
        }
    }
    usleep(200000);
}

// 隨機播放
- (IBAction)btnPlayRandom:(id)sender {
    
    if([self socketStartWithFilterType:@"MRCode_WMP_01"]){
        if (statusRandPly==0){
            
            statusRandPly=1; [self toast:@"隨機播放：開"];
            
        }else if (statusRandPly==1){
            
            statusRandPly=0; [self toast:@"隨機播放：關"];
        }
    }
    usleep(200000);
}

- (IBAction)btnTurnOffPlayer:(id)sender {
    
    [self socketStartWithFilterType:@"MRCode_WMP_00"];
    [self toast:@"關閉播放器"]; usleep(200000);
}

// view消失
-(void)viewDidDisappear:(BOOL)animated{
    [sysDege setLastTimeUsedCmd:nil];
    [sysDege setSelectedFileList:nil];
    [sysDege setSelectedFileRow:0];
}

// 跳出toast
-(void)toast:(NSString*)toastMsg{
    
    [toast showInfo:toastMsg
            bgColor:[UIColor whiteColor].CGColor
             inView:self.navigationController.view vertical:0.85];
}
@end
