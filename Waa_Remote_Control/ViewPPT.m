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
    
    int timeCounterMins;
    int timeCounterSecs;
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
    
    txtFileSelectedNowName.text=@"尚未選擇簡報檔案"; [sysDege setSelectedFileName:@""];
    
    // 初始化倒數計時
    timeCounterMins=5;
    timeCounterSecs=60;
    signRed.alpha=0;
    signYellow.alpha=0;
    labelTimeCounterMins.text=@"05";
    labelTimeCounterSecs.text=@"00";
    
}

// view切換時顯示上一個選擇的檔案
-(void)viewWillAppear:(BOOL)animated{
    
    NSString *selectedFileName=[sysDege selectedFileName];
    
    if (![selectedFileName isEqual:@""]) {
        
        txtFileSelectedNowName.text=selectedFileName;
        
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
    
    if ([[sysDege selectedFileList]objectAtIndex:[sysDege selectedFileRow]]!=nil) {
        [sysDege setSocketTypeFilter:TYPE_CODE_POWERPOINT];
        [sysDege socketStartWithMessage:Msg];
        
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
    
    // 開始倒數 - 每1秒執行一次
    [NSTimer
     scheduledTimerWithTimeInterval:1
     target:self
     selector:@selector(countingTime:)
     userInfo:nil
     repeats:YES];
    
    // 啟動socket
    [self socketStartWithFilterType:@"MRCode_PPT_10"];
    
    //暫停btn
    usleep(200000);
    
}

// 檔案清單
- (IBAction)btnFilelist:(id)sender {
    
    [sysDege setSocketTypeFilter:TYPE_CODE_POWERPOINT_TO_FILE_LIST];
    [sysDege socketStartWithMessage:[sysDege MRCode_Show_Documents]];
    
}

// 計時器功能－增加 1 分
- (IBAction)btnTimeCounterAdd:(id)sender {
    
    timeCounterMins+=1;
    timeCounterSecs=60;
    
    if (timeCounterMins<10) {
        labelTimeCounterMins.text=[NSString stringWithFormat:@"0%d",timeCounterMins];
    }else{
        labelTimeCounterMins.text=[NSString stringWithFormat:@"%d",timeCounterMins];
    }
    labelTimeCounterSecs.text=@"00";
    
}

// 計時器功能－減少 1 分
- (IBAction)btnTimeCounterReduce:(id)sender {
    
    if (timeCounterMins>1) {
        
        timeCounterMins-=1;
        timeCounterSecs=60;
        
        if (timeCounterMins<10) {
            labelTimeCounterMins.text=[NSString stringWithFormat:@"0%d",timeCounterMins];
        }else{
            labelTimeCounterMins.text=[NSString stringWithFormat:@"%d",timeCounterMins];
        }
        labelTimeCounterSecs.text=@"00";
        
    }else{
        [sysDege showAlert:@"時間太短啦！"];
    }
    
}

// view消失時
-(void)viewDidDisappear:(BOOL)animated{
    
    [sysDege setLastTimeUsedCmd:nil];
    [sysDege setSelectedFileList:nil];
    [sysDege setSelectedFileRow:0];
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

// 倒數計時 - 當扣秒少於1就扣分
-(void)countingTime:(NSTimer *)theTimer{
    
    // 如果秒數大於1
    if (timeCounterSecs>1) {
        
        timeCounterSecs-=1;
        
        if (timeCounterSecs<10) {
            labelTimeCounterSecs.text=[NSString stringWithFormat:@"0%d",timeCounterSecs];
        }else{
            labelTimeCounterSecs.text=[NSString stringWithFormat:@"%d",timeCounterSecs];
        }
        
    }else{
        
        if(timeCounterMins>1){
            
            timeCounterMins-=1;
            
            if (timeCounterMins<10) {
                labelTimeCounterMins.text=[NSString stringWithFormat:@"0%d",timeCounterMins];
            }else{
                labelTimeCounterMins.text=[NSString stringWithFormat:@"%d",timeCounterMins];
            }
            
            timeCounterSecs=60;
        }
    }

}

@end
