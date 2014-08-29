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

@interface AppDelegate : UIResponder <UIApplicationDelegate,NSStreamDelegate>
/*
    預先定義送往server端之命令變數
*/
@property (nonatomic,retain) NSString *exec_command_tmp;
@property (nonatomic,retain) NSString *MRCode_Show_Documents;
@property (nonatomic,retain) NSString *MRCode_Show_Videos;
@property (nonatomic,retain) NSString *MRCode_Show_Music;
@property (nonatomic,retain) NSString *MRCode_Run_Documents;
@property (nonatomic,retain) NSString *MRCode_Run_Videos;
@property (nonatomic,retain) NSString *MRCode_Run_Music;
@property (nonatomic,retain) NSString *MRCode_Return;
@property (nonatomic,retain) NSString *MRCode_Connect;

/*
    VIEW定義
*/
@property (nonatomic,strong) IBOutlet UIWindow *window;
@property (nonatomic,retain) UIStoryboard *board;
@property (nonatomic,retain) ViewSwitchController *viewSwitchController;

/*
    socket串流物件
 */
@property (nonatomic,retain) NSInputStream *inputStream;
@property (nonatomic,retain) NSOutputStream *outputStream;
@property (nonatomic,retain) NSString *socketOutputMsg;
// socket回傳檔案清單/socket回傳檔案清單之選取index
@property (nonatomic,retain) NSMutableArray *fileSelectedList;
@property NSInteger fileSelectedRow;
// socket回傳結果
@property (nonatomic,retain) NSString *socketLastTimeResult;
// 伺服器IP/上次使用IP/上次使用命令
@property (nonatomic,retain) NSString *serverIP;
@property (nonatomic,retain) NSString *lastTimeUsedServerIP;
@property (nonatomic,retain) NSString *lastTimeUsedCmd;
// 命令類型
@property NSInteger socketTypeFilter;



+(AppDelegate*)App;
-(void)showAlert:(NSString *)Message;
-(void)setRootViewController;
-(void)socketStartWithMessage:(NSString *)Message;
-(void)socketClose;
-(BOOL)checkServerIpFormat:(NSString *)ServerIP;


@end
