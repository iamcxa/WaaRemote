//
//  ViewPowerpoint.m
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/25.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import "ViewPPT.h"
#import "ViewMenu.h"
#import "ViewScanIP.h"



@interface ViewPPT (){
    NSTimer *autoTimer;
    int timeCounterMins,lastTimeCounterMins;
    int timeCounterSecs,lastTimeCounterSecs;
    int playStatus;
}

@end

@implementation ViewPPT

@synthesize txtFileSelectedNowName;
@synthesize signRed,signYellow;
@synthesize labelTimeCounterMins,labelTimeCounterSecs;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"@ViewPPT didLoad");
    
    // 初始化震動
    //將音效檔轉換成SystemSoundID型態
    SystemSoundID soundID;
    
    txtFileSelectedNowName.text=@"尚未選擇簡報檔案"; [sysDege setSelectedFileName:@""];
    
    // 播放/暫停狀態
    playStatus=0; // 0=暫停
    
    // 初始化倒數計時
    timeCounterMins=5;
    timeCounterSecs=60;
    signRed.alpha=0;
    signYellow.alpha=0;
    labelTimeCounterMins.text=@"05"; // 預設五分鐘
    labelTimeCounterSecs.text=@"00"; // 顯示05:“00”
    
}

// view切換時顯示上一個選擇的檔案
-(void)viewWillAppear:(BOOL)animated{
    
    NSString *selectedFileName=[sysDege selectedFileName];
    
    if (![selectedFileName isEqual:@""]) {
        
        txtFileSelectedNowName.text=[@"目前檔案：" stringByAppendingString:selectedFileName];
        
    }else{
        
        txtFileSelectedNowName.text=@"尚未選擇簡報檔案";
        
    }
}

//
-(void)appWillEnterForegroundNotification{
    NSLog(@"＠＠trigger event when will enter foreground.");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 送出訊息時強制設定檔案篩選類型, 確保一定會是ＰＰＴ類型檔案
-(void)socketStartWithFilterType:(NSString *)Msg{
    
    // 如果正在播放則計時器回復原先設定之時間
    if(playStatus==1){
        
        //timeCounterMins=lastTimeCounterMins;
        //timeCounterSecs=lastTimeCounterSecs;
        
        // 如果已經停止則備份目前設定之時間
    }else if (playStatus==0){
        
        //lastTimeCounterMins=timeCounterMins;
        //lastTimeCounterSecs=timeCounterSecs;
    }
    
    if ([[sysDege selectedFileList]objectAtIndex:[sysDege selectedFileRow]]!=nil) {
        
        [sysDege setSocketTypeFilter:TYPE_CODE_POWERPOINT]; [sysDege socketStartWithMessage:Msg];
        
        // 開始倒數 - 每1秒執行一次
        autoTimer=[NSTimer
                   scheduledTimerWithTimeInterval:1
                   target:self
                   selector:@selector(countingTime:)
                   userInfo:nil
                   repeats:YES];
        
    } else{
        
        [sysDege showAlert:@"請先選擇檔案！"];
    }
    
}

// 說明選單
- (IBAction)btnHelp:(id)sender{
    
    [[sysDege viewSwitchController]showViewHelp];
}

// 降低音量
- (IBAction)btnVolumeUp:(id)sender {
    
    [self socketStartWithFilterType:@"MRCode_PPT_14"]; usleep(200000);
}

// 提高音量
- (IBAction)btnVolumeDown:(id)sender {
    
    [self socketStartWithFilterType:@"MRCode_PPT_15"]; usleep(200000);
}

// 上一頁
- (IBAction)btnPageBack:(id)sender {
    
    [self socketStartWithFilterType:@"MRCode_PPT_12"]; usleep(200000);
}

// 下一頁
- (IBAction)btnPageNext:(id)sender {
    
    [self socketStartWithFilterType:@"MRCode_PPT_13"]; usleep(200000);
}

// 播放/暫停
- (IBAction)btnAction:(id)sender {
    
    // 目前是暫停
    if (playStatus==0) {
        
        // 啟動socket送出播放
        [self socketStartWithFilterType:@"MRCode_PPT_10"];  playStatus=1;
        
        timeCounterMins-=1; [self setCountMins];
        
        // 目前是播放
    }else if (playStatus==1){
        
        // 啟動socket送出暫停
        [self socketStartWithFilterType:@"MRCode_PPT_00"];  playStatus=0;
        
        // 關閉計時器
        [autoTimer invalidate];  autoTimer = nil;
    }
    
    //暫停btn
    usleep(200000);
}

// 檔案清單
- (IBAction)btnFilelist:(id)sender {
    
    [sysDege setSocketTypeFilter:TYPE_CODE_POWERPOINT_TO_FILE_LIST];
    [sysDege socketStartWithMessage:[sysDege MRCode_Show_Documents]];
}

// 計時器按鈕－增加 1 分
- (IBAction)btnTimeCounterAdd:(id)sender {
    
    timeCounterMins+=1; timeCounterSecs=60;
    
    [self setCountMins];
    
    labelTimeCounterSecs.text=@"00";
}

// 計時器按鈕－減少 1 分
- (IBAction)btnTimeCounterReduce:(id)sender {
    
    if (timeCounterMins>1) {
        
        timeCounterMins-=1; timeCounterSecs=60;
        
        [self setCountMins];
        
        labelTimeCounterSecs.text=@"00";
        
    }else{
        [sysDege showAlert:@"時間太短啦！"];
    }
}

// 倒數計時 - 當秒<1就扣分
-(void)countingTime:(NSTimer *)theTimer{
    
    // 播放狀態
    if(playStatus==1){
        
        // 如果秒數>0持續減少
        if (timeCounterSecs>0) {
            
            timeCounterSecs-=1;  [self setCountSecs];
            
            // 秒數＝0時減少分鐘數
        }else{
            
            if(timeCounterMins>0){
                
                timeCounterMins-=1; timeCounterSecs=60; // 秒數補滿
                
                [self setCountMins];
            }
        }
        if (timeCounterMins>1 && timeCounterMins<3) {
            
            // 亮黃燈
            signYellow.alpha=1; signRed.alpha=0;
            
            // 震動一下
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            
            
        }else if (timeCounterMins<2){
            
            // 亮紅燈
            signYellow.alpha=0; signRed.alpha=1;
            
            // 震動一下
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
        
        // 如果停止了
    }else if(playStatus==0){
        
        signYellow.alpha=0; signRed.alpha=0;
        
        [autoTimer invalidate]; autoTimer=nil;
    }
}

-(void)setCountMins{
    
    if (timeCounterMins<10) {
        labelTimeCounterMins.text=[NSString stringWithFormat:@"0%d",timeCounterMins];
    }else{
        labelTimeCounterMins.text=[NSString stringWithFormat:@"%d",timeCounterMins];
    }
}

-(void)setCountSecs{
    
    if (timeCounterSecs<10) {
        labelTimeCounterSecs.text=[NSString stringWithFormat:@"0%d",timeCounterSecs];
    }else{
        labelTimeCounterSecs.text=[NSString stringWithFormat:@"%d",timeCounterSecs];
    }
}

// view消失時
-(void)viewDidDisappear:(BOOL)animated{
    
    [sysDege setLastTimeUsedCmd:nil];
    [sysDege setSelectedFileList:nil];
    [sysDege setSelectedFileRow:0];
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
