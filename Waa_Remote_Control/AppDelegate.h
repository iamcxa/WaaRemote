//
//  AppDelegate.h
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/8.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//
#import <UIKit/UIKit.h>

@class AppSocket;
@class ViewSwitchController;
@class ViewMenu;
@class ViewVideo;
@class ViewMusic;
@class ViewFileList;
@class ViewScanIP;
@class ViewPPT;
@class toast;

/************************************************************
 *
 *                      預先定義變數
 *
 ************************************************************/

#define PORT 3579
#define TYPE_CODE_FIND_IP 0

#define TYPE_CODE_POWERPOINT 100
#define TYPE_CODE_POWERPOINT_TO_FILE_LIST 155

#define TYPE_CODE_VIDEO 200
#define TYPE_CODE_VIDEO_TO_FILE_LIST 255

#define TYPE_CODE_MUSIC 300
#define TYPE_CODE_MUSIC_TO_FILE_LIST 355

#define TYPE_CODE_POWER 900
#define TYPE_CODE_ERROR 999

@interface AppDelegate : UIResponder <UIApplicationDelegate,NSStreamDelegate>{
    UIActivityIndicatorView *activityView;
    UIView *loadingView;
    UILabel *loadingLabel;
}

/************************************************************
 *
 *                       連線中畫面變數
 *
 ************************************************************/
@property (nonatomic, retain) UIActivityIndicatorView * activityView;
@property (nonatomic, retain) UIView *loadingView;
@property (nonatomic, retain) UILabel *loadingLabel;


/************************************************************
 *
 *                   預先定義送往server端之命令變數
 *
 ************************************************************/
@property (nonatomic,retain) NSString *exec_command_tmp;
@property (nonatomic,retain) NSString *MRCode_Show_Documents;
@property (nonatomic,retain) NSString *MRCode_Show_Videos;
@property (nonatomic,retain) NSString *MRCode_Show_Music;
@property (nonatomic,retain) NSString *MRCode_Run_Documents;
@property (nonatomic,retain) NSString *MRCode_Run_Videos;
@property (nonatomic,retain) NSString *MRCode_Run_Music;
@property (nonatomic,retain) NSString *MRCode_Return;
@property (nonatomic,retain) NSString *MRCode_Connect;


/************************************************************
 *
 *                          VIEW定義
 *
 ************************************************************/
@property (nonatomic,strong) IBOutlet UIWindow *window;
@property (nonatomic,retain) UINavigationController *navigator;
@property (nonatomic,retain) UIStoryboard *board;
@property (nonatomic,retain) ViewSwitchController *viewSwitchController;
@property (nonatomic,retain) ViewScanIP *viewScanIP;
@property (nonatomic,retain) ViewMenu *viewMenu;
@property (nonatomic,retain) ViewPPT *viewPPT;
@property (nonatomic,retain) ViewFileList *viewFileList;
@property (nonatomic,retain) ViewVideo *viewVideo;
@property (nonatomic,retain) ViewMusic *viewMusic;
@property (nonatomic,retain) toast *toast;


/************************************************************
 *
 *                        socket串流物件
 *
 ************************************************************/
// socket input串流
@property (nonatomic,retain) NSInputStream *inputStream;
// socket output串流
@property (nonatomic,retain) NSOutputStream *outputStream;
// socket output字串物件
@property (nonatomic,retain) NSString *socketOutputMsg;
// socket回傳檔案清單/socket回傳檔案清單之選取index
@property (nonatomic,retain) NSMutableArray *fileSelectedList;
// 存放使用者已選取的檔案清單行數位置
@property NSInteger fileSelectedRow;
// socket回傳結果
@property (nonatomic,retain) NSString *socketLastTimeInputMsg;
// 伺服器IP/上次使用IP/上次使用命令
@property (nonatomic,retain) NSString *serverIP;
@property (nonatomic,retain) NSString *lastTimeUsedServerIP;
@property (nonatomic,retain) NSString *lastTimeUsedCmd;
// 命令類型
@property NSInteger socketTypeFilter;


/************************************************************
 *
 *                       Custom Functions
 *
 ************************************************************/
// 公用/共用呼叫
+(AppDelegate*)App;

// 設定/顯示提示dialog
-(void)showAlert:(NSString *)Message;

// 初始化views
-(void)setViewControllers;

// 開啟socket串流並送出字串Message
-(void)socketStartWithMessage:(NSString *)Message;
// 關閉socket串流連線
-(void)socketClose;
// 檢查ＩＰ格式
-(BOOL)checkServerIpFormat:(NSString *)ServerIP;

// 顯示連線中畫面
-(UIView *)loadingView;
// 消除連線中畫面
-(void)loadingStop;

// 記錄/讀取上次使用IP
-(void)saveLastTimeServerIPtoFile:(NSString *)IP;
-(NSString *)getLastTimeServerIPfromFile;


@end
