//
//  ViewMusic.m
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/27.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import "ViewMusic.h"
#import "toast.h"

@implementation ViewMusic{
    
    int statusPlay;
    int statusMute;
    int statusRandPly;
    int statusReptPly;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    // 設定狀態旗標
    statusPlay=0; statusMute=0;
    statusRandPly=0; statusReptPly=0;
    
}

// 送出訊息時強制設定檔案篩選類型, 確保一定會是對應類型檔案
-(BOOL)socketStartWithFilterType:(NSString *)Msg{
    
    if ([[sysDege selectedFileList]objectAtIndex:[sysDege selectedFileRow]]!=nil) {
        [sysDege setSocketTypeFilter:TYPE_CODE_VIDEO];
        [sysDege socketStartWithMessage:Msg];
        
        return YES;
        
    } else{
        
        [self toast:@"請先選擇檔案！"];
        [self btnFileList:self];
        return NO;
    }
}

// 停止
- (IBAction)btnStop:(id)sender {
    
    [self socketStartWithFilterType:@"MRCode_WMP_19"];
    [self toast:@"停止"]; usleep(200000);
}

// close wmp
- (IBAction)btnEndWMPlayer:(id)sender{
    
    [self socketStartWithFilterType:@"MRCode_WMP_00"];
    [self toast:@"關閉播放器"]; usleep(200000);
}

// 繼續或暫停
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

// 上一首
- (IBAction)btnLastOne:(id)sender {
    
    [self socketStartWithFilterType:@"MRCode_WMP_12"];
    [self toast:@"上一首"]; usleep(200000);
}

// 下一首
- (IBAction)btnNextOne:(id)sender {
    
    [self socketStartWithFilterType:@"MRCode_WMP_13"];
    [self toast:@"下一首"]; usleep(200000);
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

// 大聲
- (IBAction)btnVolumeBigger:(id)sender {
    
    [self socketStartWithFilterType:@"MRCode_WMP_15"];
    [self toast:@"提高音量"]; usleep(200000);
}

// 小聲
- (IBAction)bntVolumeLower:(id)sender {
    
    [self socketStartWithFilterType:@"MRCode_WMP_16"];
    [self toast:@"降低音量"]; usleep(200000);
}

// 快轉
- (IBAction)btnForward:(id)sender {
    
    [self socketStartWithFilterType:@"MRCode_WMP_17"];
    [self toast:@"播放：快轉"]; usleep(200000);
}

// 減速
- (IBAction)btnBack:(id)sender {
    
    [self socketStartWithFilterType:@"MRCode_WMP_18"];
    [self toast:@"播放：減速"]; usleep(200000);
}

// 重複播放
- (IBAction)btnRepeat:(id)sender {
    
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
- (IBAction)btnRandom:(id)sender {
    
    if([self socketStartWithFilterType:@"MRCode_WMP_01"]){
        if (statusRandPly==0){
            
            statusRandPly=1; [self toast:@"隨機播放：開"];
            
        }else if (statusRandPly==1){
            
            statusRandPly=0; [self toast:@"隨機播放：關"];
        }
    }
    usleep(200000);
}

// 說明選單
- (IBAction)btnHelp:(id)sender {
    
    [[sysDege viewSwitchController]showViewHelp];
}


// 檔案清單
- (IBAction)btnFileList:(id)sender {
    
    [sysDege setSocketTypeFilter:TYPE_CODE_MUSIC_TO_FILE_LIST];
    [sysDege socketStartWithMessage:[sysDege MRCode_Show_Music]];
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
