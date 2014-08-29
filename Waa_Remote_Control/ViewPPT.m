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


@interface ViewPPT ()

@end

@implementation ViewPPT


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"@ViewPPT didLoad");
    
    [self showFileInfo];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showFileInfo{
    
    if([[sysDege fileSelectedList]objectAtIndex:[sysDege fileSelectedRow]]!=nil){
        ViewPPT *viewppt=[[ViewPPT alloc]init];
        // 讀取行號/正在播放檔案名稱/下一個檔案名稱
        NSInteger selectedRow=[sysDege fileSelectedRow];
        NSString *thisFileName=[[sysDege fileSelectedList]objectAtIndex:selectedRow];
        NSString *nextFileName=[[sysDege fileSelectedList]objectAtIndex:selectedRow+1];
        
        // 顯示“正在播放”檔案名稱與標題
        viewppt.txtFileSelectedNowTitle.alpha=1;
        viewppt.txtFileSelectedNowName.alpha=1;
        viewppt.txtFileSelectedNowName.text=thisFileName;
        
        // 顯示“下一個”檔案名稱與小標題
        viewppt.txtFileSelectedNextTtle.alpha=1;
        viewppt.txtFileSelectedNextName.alpha=1;
        viewppt.txtFileSelectedNextName.text=nextFileName;
        
    }else{
        ViewPPT *viewppt=[[ViewPPT alloc]init];
        // 隱藏“正在播放”檔案名稱與標題
        viewppt.txtFileSelectedNowTitle.alpha=0;
        viewppt.txtFileSelectedNowName.alpha=0;
        
        // 隱藏“下一個”檔案名稱與小標題
        viewppt.txtFileSelectedNextTtle.alpha=0;
        viewppt.txtFileSelectedNextName.alpha=0;
    }
}

// 送出訊息時強制設定檔案篩選類型, 確保一定會是ＰＰＴ類型檔案
-(void)socketStartWithFilterType:(NSString *)Msg{
    
    if ([[sysDege fileSelectedList]objectAtIndex:[sysDege fileSelectedRow]]!=nil) {
        [sysDege setSocketTypeFilter:TYPE_CODE_POWERPOINT];
        [sysDege socketStartWithMessage:Msg];
        
    } else{
        
        [sysDege showAlert:@"請先選擇檔案！"];
        
    }
}

// 說明選單
- (IBAction)btnHelp:(id)sender{
    [self performSegueWithIdentifier:@"GotoViewHelp" sender:self];
}

// 回功能選單
- (IBAction)btnMenu:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    if([sysDege lastTimeUsedCmd]!=nil){
        NSLog(@"@lastTimeUsedCmd found=>%@",[sysDege lastTimeUsedCmd]);
        [sysDege socketStartWithMessage:[sysDege lastTimeUsedCmd]];
        usleep(100000);
    }
    [self socketStartWithFilterType:@"MRCode_PPT_10"];
    usleep(200000);
}

// 檔案清單
- (IBAction)btnFilelist:(id)sender {
    [sysDege setSocketTypeFilter:TYPE_CODE_POWERPOINT_TO_FILE_LIST];
    [sysDege socketStartWithMessage:[sysDege MRCode_Show_Documents]];
}

// 計時器功能－增加 10 秒
- (IBAction)btnTimeAdd:(id)sender {
    
}

// 計時器功能－減少 10 秒
- (IBAction)btnTimeReduce:(id)sender {
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [sysDege setLastTimeUsedCmd:nil];
    [sysDege setFileSelectedList:nil];
    [sysDege setFileSelectedRow:0];
}
@end
