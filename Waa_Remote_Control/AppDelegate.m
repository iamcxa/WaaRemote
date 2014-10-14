//
//  AppDelegate.m
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/8.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//
#import "QuartzCore/QuartzCore.h"
#import "AppDelegate.h"
#import "ViewSwitchController.h"
#import "ViewScanIP.h"
#import "toast.h"

@implementation AppDelegate{
}

/************************************************************
 *
 *                   Custom Functions Start
 *
 ************************************************************/
@synthesize board;
@synthesize viewScanIP;
//@synthesize viewFileList;
//@synthesize viewMusic;
//@synthesize viewMenu;
@synthesize viewSwitchController;

// 連線中畫面
@synthesize loadingLabel;
@synthesize loadingView;
@synthesize activityView;

// Toast物件
@synthesize toast;

// 連線結果
@synthesize result;

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 預先設定送到server的命令變數
    _MRCode_Show_Documents=@"MRCode_Show_Documents";
    _MRCode_Show_Videos=@"MRCode_Show_Videos";
    _MRCode_Show_Music=@"MRCode_Show_Music";
    _MRCode_Return=@"MRCode_Return";
    _MRCode_Connect=@"connect";
    _MRCode_Run_Documents=@"MRCode_Run_Documents";
    _MRCode_Run_Videos=@"MRCode_Run_Videos";
    _MRCode_Run_Music=@"MRCode_Run_Music";
    
    [self setViewControllers];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/************************************************************
 *
 *                   Custom Functions Start
 *
 ************************************************************/
+(AppDelegate*)App{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

// 初始化views
-(void)setViewControllers{
    
    // 讀取上次使用過ＩＰ
    _lastTimeUsedServerIP=[self getLastTimeServerIPfromFile];
    
    // remove現有所有views
    for(UIView *subview in [[[[sysDege window]rootViewController]view] subviews]){
        // remove the subview with tag equal to "9099"
        // if(subview.tag == 90999){
        [subview removeFromSuperview];
        //    NSLog(@"subview =%@",subview);
        //}
    }
    
    // 初始化viewswitch控制器
    viewSwitchController=[[ViewSwitchController alloc] init] ;
    viewSwitchController.title=@"Waa遙控器";
    
    // 建立一個navigator
    self.navigator = [[UINavigationController alloc] init];
    self.navigator.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    // 將viewswitch放入navigator中
    [self.navigator pushViewController:viewSwitchController animated:NO];
    
    // 將navigator放入window中
    [self.window addSubview:self.navigator.view];
    
    // 設定navigator為root
    [self.window setRootViewController:self.navigator];
    //[self.window makeKeyAndVisible];
}


/************************************************************
 *
 *                    socket事件監聽器
 *
 ************************************************************/
-(void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    
    NSString *event=@"event"; result=nil;
    
    switch (streamEvent) {
            
        case NSStreamEventNone:
            
            result = @"NSStreamEventNone"; break;
            
        case NSStreamEventOpenCompleted:
            
            result = @"NSStreamEventOpenCompleted"; break;
            
        case NSStreamEventHasBytesAvailable: // socket收到訊息
            
            result = @"NSStreamEventHasBytesAvailable";
            
            if (theStream == _inputStream) {
                NSMutableData *input = [[NSMutableData alloc] init];
                
                Byte buffer[1024]; NSInteger len;
                
                while([_inputStream hasBytesAvailable])
                {
                    // 等待
                    NSLog(@"@socket steam waiting for 0.5s..."); usleep(500000);
                    
                    len = [_inputStream read:buffer maxLength:1024];
                    
                    if (len > 0) [input appendBytes:buffer length:len];
                    
                }
                
                // 收到的訊息
                /*
                 * 舊有方法 - 解碼傳送過來的 writeByte 訊息
                 * socketLastTimeResult =[[NSString alloc]initWithData:input encoding:NSUTF8StringEncoding];
                 * 新方法 - writeByte using unicode 可能未來有更好的方式
                 * 將裝載送過來之Unicode訊息的NSMutableData物件轉為NSString.
                 */
                NSString *rawData=[[NSString alloc]initWithData:input encoding:NSNonLossyASCIIStringEncoding];
                // 再將NSString轉為NSDATA
                NSData *dataenc=[rawData dataUsingEncoding:NSNonLossyASCIIStringEncoding];
                // 最後再轉換成NSString
                _lastTimeSocketInputMsg =[[NSString alloc]initWithData:dataenc encoding:NSNonLossyASCIIStringEncoding];
                // event 輸出 received, 表示有收到字串.
                event=@"received"; result=[NSString stringWithString:_lastTimeSocketInputMsg];
                
                // 輸出已經接收到的訊息
                //NSLog(@"@received=>'%@'",_lastTimeSocketInputMsg);
                
                [_inputStream close]; [self setLastTimeSocketInputMsg:_lastTimeSocketInputMsg];
                
                NSString *toastTag=@"server=>";
                NSString *toastMsg=[toastTag stringByAppendingString:_lastTimeSocketInputMsg];
                
                [toast showInfo:toastMsg
                        bgColor:[UIColor whiteColor].CGColor
                         inView:self.navigator.view vertical:0.85];
            }
            
            break;
            
        case NSStreamEventHasSpaceAvailable: // socket輸出訊息
            
            result = @"NSStreamEventHasSpaceAvailable";
            
            if (theStream == _outputStream) {
                
                NSData *bytes2 = [_socketOutputMsg dataUsingEncoding:NSNonLossyASCIIStringEncoding];
                
                /*
                 *  舊方法
                 *  NSData *bytes2 = [NSData dataWithBytes:(__bridge const void *)(socketOutputMsg) length:
                 *   (socketOutputMsg.length)+1];
                 */
                Byte *Buff = (Byte *)[bytes2 bytes];
                
                // 輸出後關閉串流
                [_outputStream write:Buff maxLength:strlen((const char*)Buff)+1];
                
                // 輸出已經輸出的訊息
                NSLog(@"@outputed=>%@",_socketOutputMsg);
                
                [_outputStream close];
            }
            
            break;
            
        case NSStreamEventErrorOccurred:
            
            result = @"NSStreamEventErrorOccurred";
            
            event=@"error";
            
            NSLog(@"Error code:%ld:%@",(long)[[theStream streamError] code],
                  
                  [[theStream streamError] localizedDescription]);
            
            [sysDege showAlert:@"連線失敗！"];
            
            break;
            
        case NSStreamEventEndEncountered:
            
            result = @"NSStreamEventEndEncountered";
            
            event=@"EndEncountered";
            
            NSLog(@"Error code:%ld:%@",(long)[[theStream streamError] code],
                  
                  [[theStream streamError] localizedDescription]);
            
            [sysDege showAlert:@"連線異常中止！"];
            
            break;
            
        default:
            
            result = @"Unknown"; [self socketClose];  break;
    }
    
    NSLog(@"@%@—%@.",event,result);
    
    if([event isEqual:@"received"]) {
        if(result.length>1){
            if(![result hasPrefix:@"NoFile"]){
                // 如果回傳結果長度大於1而且不包含NoFile關鍵字才繼續
                [self socketClientRespond];
            }else [sysDege showAlert:@"該資料夾沒有相關檔案！"];
        }else {
            // 收到空字串
            NSLog(@"@received a null here! check server.");
            [sysDege showAlert:@"發生錯誤！請重新連線！"];
            [self setViewControllers];
        }
    }
    
    // 移除連線中畫面
    [self loadingStop];
    
}


/************************************************************
 *
 *                    socket啟動/關閉
 *
 ************************************************************/
// socket開啟
-(void)socketStart:(NSString *)ServerIP{
    // 顯示loading畫面
    [[[[sysDege window]rootViewController]view] addSubview: [self loadingView]];
    
    // 記錄上次使用之SERVER IP
    NSLog(@"@socket start with this server:%@",ServerIP);
    [self setLastTimeUsedServerIP:ServerIP];
    [self saveLastTimeServerIPtoFile:_lastTimeUsedServerIP];
    
    // 清除上次連線結果
    result=nil;
    
    CFWriteStreamRef writeStream; CFReadStreamRef readStream;
    
    CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault,
                                       (CFStringRef)CFBridgingRetain(ServerIP),
                                       PORT,
                                       &readStream,
                                       &writeStream);
    
    _outputStream= (__bridge NSOutputStream *)writeStream;
    [_outputStream setDelegate:self];
    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]forMode:NSDefaultRunLoopMode];
    [_outputStream open];
    
    // 等待
    NSLog(@"@socket steam waiting for 0.1s..."); usleep(100000);
    
    _inputStream = (__bridge NSInputStream *)readStream;
    [_inputStream setDelegate:self];
    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]forMode:NSDefaultRunLoopMode];
    [_inputStream open];
    
    
    // 逾時判斷
    [NSTimer
     scheduledTimerWithTimeInterval:SOCKET_TIMEOUT
     target:self
     selector:@selector(getSocketStatus:)
     userInfo:nil
     repeats:NO];
}

// socket關閉
-(void)socketClose{
    [_outputStream close];
    [_outputStream removeFromRunLoop:[NSRunLoop currentRunLoop]forMode:NSDefaultRunLoopMode];
    [_outputStream setDelegate:nil];
    [_inputStream close];
    [_inputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [_inputStream setDelegate:nil];
    
    // 移除連線中畫面
    [self loadingStop];
    
    NSLog(@"@socket closed.");
}

// 開啟socket連線
-(void)socketStartWithMessage:(NSString *)Message{
    
    // 編碼
    _socketOutputMsg=[Message stringByAppendingString:@"\n"];
    
    // 開始socket通訊
    [self socketStart:self.serverIP];
}

// 逾時判斷
-(void)getSocketStatus:(NSTimer *)theTimer{
    
    NSLog(@"@—%@.",result);
    NSLog(@"@socket connection status check...");
    
    if((![result isEqual:@"NSStreamEventHasBytesAvailable"])
       &&(![result isEqual:@"NSStreamEventOpenCompleted"])
       &&(![result isEqual:@"connect"])
       &&(![result isEqual:@"NSStreamEventHasSpaceAvailable"])){
        
        NSLog(@"@socket connection timeout!"); [self socketClose];
        
        [self showAlert:@"連線逾時！"];
        
    }else{
        
        NSLog(@"@socket connection is alive.");
        
    }
}

/************************************************************
 *
 *                    socket收到訊息後執行特定動作
 *
 ************************************************************/
-(void)socketClientRespond{
    NSLog(@"@socket doing a response with type=>%ld",(long)_socketTypeFilter);
    switch (_socketTypeFilter) {
            
        case TYPE_CODE_FIND_IP:
            // 驗證server端訊息
            if ([_lastTimeSocketInputMsg isEqualToString:[self MRCode_Connect]]) {
                [self.viewSwitchController showViewMenu];
                // 20141014 沒明確用途暫時關閉
                //}else{
                //   [self showAlert:socketLastTimeInputMsg];
            }
            
            break;
            
        case TYPE_CODE_POWERPOINT_TO_FILE_LIST:
            
            [self.viewSwitchController showViewFileList:[sysDege MRCode_Show_Documents]];
            
            break;
            
        case TYPE_CODE_VIDEO_TO_FILE_LIST:
            
            [self.viewSwitchController showViewFileList:[sysDege MRCode_Show_Videos]];
            
            break;
            
        case TYPE_CODE_MUSIC_TO_FILE_LIST:
            
            [self.viewSwitchController showViewFileList:[sysDege MRCode_Show_Music]];
            
            break;
            
        case TYPE_CODE_ERROR:
            
            [self.viewSwitchController disconnect];
            
            break;
    }
    
    // 清空輸出入暫存
    //NSLog(@"@clean input/output.");
    //_lastTimeSocketInputMsg=nil; _socketOutputMsg=nil;
}


/************************************************************
 *
 *                         ＩＰ格式驗證
 *
 ************************************************************/
// 驗證伺服器IP格式是否全都是數字
-(BOOL)validateServerIP:(NSString *)ServerIP{
    NSString *regex=@"[0-9]{1,3}";
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:ServerIP];
}

// 驗證是否IP各區段格式都落在0~255之間
-(BOOL)checkServerIpFormat:(NSString *)ServerIP
{
    if (![ServerIP rangeOfString:@"."].length==0) {
        NSArray *IPArray=[ServerIP componentsSeparatedByString:@"."];
        if (IPArray.count==4) {
            NSInteger IPa=[[IPArray objectAtIndex:0] integerValue];
            NSInteger IPb=[[IPArray objectAtIndex:1] integerValue];
            NSInteger IPc=[[IPArray objectAtIndex:2] integerValue];
            NSInteger IPd=[[IPArray objectAtIndex:3] integerValue];
            if ((IPa<256)&&(IPa>=0)){
                if ((IPb<256)&&(IPc>=0)){
                    if ((IPc<256)&&(IPa>=0)){
                        if ((IPd<256)&&(IPa>=0)){
                            NSLog(@"@checkIP(%ld,%ld,%ld,%ld)->okay",
                                  (long)IPa,(long)IPb,(long)IPc,(long)IPd);
                            return true;
                        }else [self showAlert:@"IP區段4格式錯誤！"];return false;
                    }else [self showAlert:@"IP區段3格式錯誤！"];return false;
                }else [self showAlert:@"IP區段2格式錯誤！"];return false;
            }else [self showAlert:@"IP區段1格式錯誤！"];return false;
        }else [self showAlert:@"IP輸入不完整！"];return false;
    }else [self showAlert:@"IP格式錯誤！"];  return false;
}


/************************************************************
 *
 *                        跳出通知dialog
 *
 ************************************************************/
-(void)showAlert:(NSString *)Message
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:Message
                          message:nil
                          delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"OK",nil];
    [alert show];
}


/************************************************************
 *
 *                           連線中畫面
 *
 ************************************************************/
// loading結束
-(void)loadingStop{
    [activityView stopAnimating];
    [loadingView removeFromSuperview];
}

// 開始loading
-(UIView *)loadingView{
    loadingView.tag=90999;
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(75, 220, 170, 110)];
    loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.85];
    loadingView.clipsToBounds = YES;
    loadingView.layer.cornerRadius = 10.0;
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(65, 30, activityView.bounds.size.width, activityView.bounds.size.height);
    [loadingView addSubview:activityView];
    
    loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 75, 130, 22)];
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.textColor = [UIColor whiteColor];
    loadingLabel.adjustsFontSizeToFitWidth = YES;
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.text = @"連線中";
    [loadingView addSubview:loadingLabel];
    
    [[[[sysDege window]rootViewController]view] addSubview:loadingView];
    
    [activityView startAnimating];
    
    return loadingView;
}


/************************************************************
 *
 *                      記錄與讀取上次使用ＩＰ
 *
 ************************************************************/
// 從檔案讀取上次使用ＩＰ
-(NSString *)getLastTimeServerIPfromFile{
    
    //取得可讀寫的路徑
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathList  objectAtIndex:0];
    path = [path stringByAppendingPathComponent:@"lastTimeServerIP"];
    
    //讀取檔案
    NSString *rdata = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    if(rdata!=nil) NSLog(@"@Last time used IP Found! ==>'%@'",rdata);
    
    return rdata;
}

// 記錄上次使用ＩＰ
-(void)saveLastTimeServerIPtoFile:(NSString *)IP{
    
    //取得可讀寫的路徑
    NSArray *pathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathList  objectAtIndex:0];
    
    //加上檔名
    path = [path stringByAppendingPathComponent:@"lastTimeServerIP"];
    //NSLog(@"@存取檔案的路徑：'%@'",path);
    
    //判斷檔案是否存在
    if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        //NSLog(@"@檔案存在，開始刪除：'%@'",path);
        //刪除檔案
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    
    //寫入檔案
    NSString *data = _lastTimeUsedServerIP;
    [data writeToFile:path atomically:NO encoding:NSUTF8StringEncoding error:nil];
}

@end
