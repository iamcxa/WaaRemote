//
//  ViewPowerpoint.m
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/25.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import "ViewPPT.h"
#import "ViewScanIP.h"
#import "toast.h"

@interface ViewPPT (){
    NSTimer *autoTimer;
    int timeCounterMins,lastTimeCounterMins;
    int timeCounterSecs,lastTimeCounterSecs;
    int playStatus;
    NSString *selectedFileName;
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
    
    [self initFlags];
}


// view切換
-(void)viewWillAppear:(BOOL)animated{
    
    [self initFlags];
}

// ＡＰＰ退入幕後
-(void)appWillEnterForegroundNotification{
    
    NSLog(@"＠＠trigger event when will enter foreground.");
}

// view 被切換
-(void)viewWillDisappear:(BOOL)animated{
    
    NSLog(@"@ViewPPT viewWillDisappear");
    [self initFlags];
}

// 初始化各種旗標
-(void)initFlags{
    
    // 播放/暫停狀態
    playStatus=0; // 0=暫停
    
    // 初始化燈號
    signRed.alpha=0;
    signYellow.alpha=0;
    
    // 初始化倒數計時
    timeCounterMins=5;
    timeCounterSecs=60;
    labelTimeCounterMins.text=@"05"; // 預設五分鐘
    labelTimeCounterSecs.text=@"00"; // 顯示05:“00”
    
    // 顯示已選取檔案
    selectedFileName=[sysDege selectedFileName];
    
    txtFileSelectedNowName.text=@"尚未選擇簡報檔案";
    
    if (selectedFileName.length!=0) {
        
        if (![selectedFileName containsString:@"ppt"]) {
            
            // 清空已選取檔案
            [sysDege setLastTimeUsedCmd:nil];
            [sysDege setSelectedFileList:nil];
            [sysDege setSelectedFileRow:0];
            [sysDege setSelectedFileName:nil];
            
            // 強制該變數更新
             selectedFileName=nil;
        }else{
            
            // 指定文字給label
            txtFileSelectedNowName.text=[@"選取：" stringByAppendingString:selectedFileName];
        }
    }
}

// 送出訊息時強制設定檔案篩選類型, 確保一定會是ＰＰＴ類型檔案
-(void)socketStartWithFilterType:(NSString *)Msg{
    
    if ([[sysDege selectedFileList]objectAtIndex:[sysDege selectedFileRow]]!=nil) {
        
        [sysDege setSocketTypeFilter:TYPE_CODE_POWERPOINT]; [sysDege socketStartWithMessage:Msg];
        
        if([Msg isEqual:@"MRCode_PPT_10"] || [Msg isEqual:@"MRCode_PPT_00"]){
            // 開始倒數 - 每1秒執行一次
            autoTimer=[NSTimer
                       scheduledTimerWithTimeInterval:1.0
                       target:self
                       selector:@selector(countingTime:)
                       userInfo:nil
                       repeats:YES];
        }
    } else{
        
        [self toast:@"請先選擇檔案！"]; [self btnFilelist:self];
    }
}

// 關閉ＰＰＴ
- (IBAction)btnPowerOff:(id)sender {
    
    [sysDege setSocketTypeFilter:TYPE_CODE_POWERPOINT];
    [sysDege socketStartWithMessage:@"MRCode_PPT_00"];
}

// 說明選單
- (IBAction)btnHelp:(id)sender{
    
    [[sysDege viewSwitchController]showViewHelp];
}

// 降低音量
- (IBAction)btnVolumeUp:(id)sender {
    
    [self socketStartWithFilterType:@"MRCode_PPT_14"];
}

// 提高音量
- (IBAction)btnVolumeDown:(id)sender {
    
    [self socketStartWithFilterType:@"MRCode_PPT_15"];
}

// 上一頁
- (IBAction)btnPageBack:(id)sender {
    
    [self socketStartWithFilterType:@"MRCode_PPT_12"];
}

// 下一頁
- (IBAction)btnPageNext:(id)sender {
    
    [self socketStartWithFilterType:@"MRCode_PPT_13"];
}

// 播放/暫停
- (IBAction)btnAction:(id)sender {
    
    // 目前是暫停
    if (playStatus==0) {
        
        [self playPPT];
        
        // 分鐘-1
        timeCounterMins-=1; [self setCountMins];
        
        // 目前是播放
    }else if (playStatus==1){
        
        [self stopPPT];
    }
}

// 播放ＰＰＴ
-(void)playPPT{
    
    // 啟動socket送出播放
    [self socketStartWithFilterType:@"MRCode_PPT_10"];  playStatus=1;
}

// 停止ＰＰＴ
-(void)stopPPT{
    
    // 啟動socket送出暫停
    [self socketStartWithFilterType:@"MRCode_PPT_00"];  playStatus=0;
    [self stopTimer];
}

// 停止計時器
-(void)stopTimer{
    
    // 關閉計時器
    autoTimer = nil; [autoTimer invalidate];
}

// 檔案清單
- (IBAction)btnFilelist:(id)sender{
    
    // 停止ＰＰＴ
    [self stopTimer];
    
    // 重設旗標
    [self initFlags];
    
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
        [self toast:@"時間太短啦！"];
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
            
            if(timeCounterSecs==59){
                
                // 震動一下
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                
                // 亮黃燈
                signYellow.alpha=1; signRed.alpha=0;
            }
            
        }else if (timeCounterMins<2){
            
            if(timeCounterSecs==59){
                
                // 震動一下
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                
                // 亮紅燈
                signYellow.alpha=0; signRed.alpha=1;
            }
        }else{
            
            // 熄滅黃紅燈
            signYellow.alpha=0; signRed.alpha=0;
        }
        
        // 如果停止了
    }else if(playStatus==0){
        
        signYellow.alpha=0; signRed.alpha=0;
        
        [self stopTimer];
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

// 跳出toast
-(void)toast:(NSString*)toastMsg{
    
    [toast showInfo:toastMsg
            bgColor:[UIColor whiteColor].CGColor
             inView:self.navigationController.view vertical:0.85];
}

@end
