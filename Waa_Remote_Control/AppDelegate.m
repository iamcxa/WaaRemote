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

@implementation AppDelegate

@synthesize board;
//@synthesize navigationController;
//@synthesize viewFileList;
@synthesize viewScanIP;
//@synthesize viewMusic;
//@synthesize viewMenu;
@synthesize toast;
@synthesize viewSwitchController;
@synthesize socketTypeFilter;
@synthesize socketOutputMsg;
@synthesize fileSelectedRow;
@synthesize socketLastTimeResult;

@synthesize socketMsg;

@synthesize loadingLabel;
@synthesize loadingView;
@synthesize activityView;

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    //加背景圖
    //[self.navigator.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_image"] forBarMetrics:UIBarMetricsDefault];
    //改變按鈕顏色
    //[self.navigator.navigationBar setTintColor:[UIColor orangeColor]];
    
    
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

/*
 
 Custom Functions
 
 */

+(AppDelegate*)App{
    return (AppDelegate*)[UIApplication sharedApplication].delegate;
}

-(void)setViewControllers{
        for(UIView *subview in [[[[sysDege window]rootViewController]view] subviews]){
            // remove the subview with tag equal to "9099"
           // if(subview.tag == 90999){
                [subview removeFromSuperview];
            //    NSLog(@"subview =%@",subview);
            //}
        }
    
    // 設定根控制器
    viewSwitchController=[[ViewSwitchController alloc] init] ;
    viewSwitchController.title=@"Waa遙控器";
    
    //建立一個navigator
    self.navigator = [[UINavigationController alloc] init];
    self.navigator.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    //將mainView放入navigator中
    [self.navigator pushViewController:viewSwitchController animated:NO];
    
    //將navigator放入window中
    [self.window addSubview:self.navigator.view];
    
    
    [self.window setRootViewController:self.navigator];
    //[self.window makeKeyAndVisible];
}

/*
 
 showAlert
 
 */
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


/*
 
 Socket
 
 */
-(void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    
    NSString *event=@"event";
    NSString *result;
    
    switch (streamEvent) {
            
        case NSStreamEventNone:
            
            result = @"NSStreamEventNone";
            
            break;
            
        case NSStreamEventOpenCompleted:
            
            result = @"NSStreamEventOpenCompleted";
            
            break;
            
        case NSStreamEventHasBytesAvailable: // socket收到訊息
            
            result = @"NSStreamEventHasBytesAvailable";
            
            if (theStream == _inputStream) {
                NSMutableData *input = [[NSMutableData alloc] init];
                
                Byte buffer[1024]; NSInteger len;
                
                while([_inputStream hasBytesAvailable])
                {
                    // 等待
                    NSLog(@"@socket steam waiting 1s..."); usleep(100000);
                    
                    len = [_inputStream read:buffer maxLength:1024];
                    
                    if (len > 0) [input appendBytes:buffer length:len];
                    
                    
                }
                
                // 收到的訊息
                // 舊有方法 - 解碼傳送過來的 writeByte 訊息
                //socketLastTimeResult =[[NSString alloc]initWithData:input encoding:NSUTF8StringEncoding];
                
                // 新方法 - writeByte using unicode 可能未來有更好的方式
                // 將裝載送過來之Unicode訊息的NSMutableData物件轉為NSString.
                NSString *rawData=[[NSString alloc]initWithData:input encoding:NSNonLossyASCIIStringEncoding];
                // 再將NSString轉為NSDATA
                NSData *dataenc=[rawData dataUsingEncoding:NSNonLossyASCIIStringEncoding];
                // 最後再轉換成NSString
                socketLastTimeResult =[[NSString alloc]initWithData:dataenc encoding:NSNonLossyASCIIStringEncoding];
                // event 輸出 received, 表示有收到字串.
                event=@"received"; result=[NSString stringWithString:socketLastTimeResult];
                
                [_inputStream close];
                
                [sysDege setSocketLastTimeResult:socketLastTimeResult];
                
                //[self loadingStop];
                
                //                [toast showInfo:socketLastTimeResult
                //                        bgColor:[UIColor whiteColor].CGColor
                //                         inView:self.navigator.view
                //                       vertical:0.7];
                
                
                
            }
            
            break;
            
        case NSStreamEventHasSpaceAvailable:
            
            result = @"NSStreamEventHasSpaceAvailable";
            
            if (theStream == _outputStream) {
                
                NSLog(@"@output=>%@",socketOutputMsg);
                
                NSData *bytes2 = [socketOutputMsg dataUsingEncoding:NSNonLossyASCIIStringEncoding];
                
                // NSData *bytes2 = [NSData dataWithBytes:(__bridge const void *)(socketOutputMsg) length:(socketOutputMsg.length)+1];
                
                Byte *Buff = (Byte *)[bytes2 bytes];
                
                //輸出後關閉串流
                [_outputStream write:Buff maxLength:strlen((const char*)Buff)+1];
                [_outputStream close];
                
                
            }
            break;
            
        case NSStreamEventErrorOccurred:
            
            result = @"NSStreamEventErrorOccurred";
            
            [sysDege showAlert:@"連線失敗！"];
            
            [self socketClose];
            
            break;
            
        case NSStreamEventEndEncountered:
            
            result = @"NSStreamEventEndEncountered";
            
            event=@"error";
            
            NSLog(@"Error code:%ld:%@",(long)[[theStream streamError] code],
                  
                  [[theStream streamError] localizedDescription]);
            [self socketClose];
            break;
            
        default:
            
            [self socketClose];
            
            result = @"Unknown";
            
            break;
    }
    
    NSLog(@"@%@—%@.",event,result);
    
    if([event isEqual:@"received"]) {
        if(result.length>1){
            if(![result hasPrefix:@"NoFile"]){
                // 如果回傳結果長度大於1而且不包含NoFile關鍵字才繼續
                [self socketClientRespond];
            }else [sysDege showAlert:@"該資料夾沒有相關檔案！"];
        }else {
            NSLog(@"@received a null here! check server.");
            [sysDege showAlert:@"發生錯誤！請重新連線！"];
            [self setViewControllers];
            
        }
    }
    
    [self loadingStop];
    
    if([event isEqual:@"error"]) [self.viewSwitchController disconnect];
    
}

-(void)setEncodingSockeOutputMsg:(NSString *)Message{
    socketOutputMsg=[Message stringByAppendingString:@"\n"];
}

-(void)socketStart:(NSString *)ServerIP{
    
    [[[[sysDege window]rootViewController]view] addSubview: [self loadingView]];
    
    [self setLastTimeUsedServerIP:ServerIP];
    CFWriteStreamRef writeStream;
    CFReadStreamRef readStream;
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
    NSLog(@"@socket steam waiting 2s..."); usleep(200000);
    
    _inputStream = (__bridge NSInputStream *)readStream;
    [_inputStream setDelegate:self];
    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]forMode:NSDefaultRunLoopMode];
    [_inputStream open];
    
}

-(void)socketClose
{
    
    [_outputStream close];
    [_outputStream removeFromRunLoop:[NSRunLoop currentRunLoop]forMode:NSDefaultRunLoopMode];
    [_outputStream setDelegate:nil];
    [_inputStream close];
    [_inputStream removeFromRunLoop:[NSRunLoop currentRunLoop]
                            forMode:NSDefaultRunLoopMode];
    [_inputStream setDelegate:nil];
    
    
}

-(BOOL)validateServerIP:(NSString *)ServerIP{
    NSString *regex=@"[0-9]{1,3}";
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:ServerIP];
}

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
                            NSLog(@"@checkIP(%ld,%ld,%ld,%ld)->okay",(long)IPa,(long)IPb,(long)IPc,(long)IPd);
                            return true;
                        }else [self showAlert:@"IP區段4格式錯誤！"];return false;
                    }else [self showAlert:@"IP區段3格式錯誤！"];return false;
                }else [self showAlert:@"IP區段2格式錯誤！"];return false;
            }else [self showAlert:@"IP區段1格式錯誤！"];return false;
        }else [self showAlert:@"IP輸入不完整！"];return false;
    }else [self showAlert:@"IP格式錯誤！"];  return false;
}

// 如果本地socket有收到訊息,則執行特定動作
-(void)socketClientRespond{
    switch (socketTypeFilter) {
            
        case TYPE_CODE_FIND_IP:
            // 驗證server端訊息
            if ([socketLastTimeResult isEqualToString:[self MRCode_Connect]]) {
                [self.viewSwitchController showViewMenu];
            }else{
                [self showAlert:socketLastTimeResult];
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
            
        default:
            
            
            break;
    }
    
    // 清空輸出入暫存
    NSLog(@"@clean input/output.");
    socketLastTimeResult=nil; socketOutputMsg=nil;
}

-(void)socketStartWithMessage:(NSString *)Message{
    [self setEncodingSockeOutputMsg:Message];
    [self socketStart:[self serverIP]];
}

-(void)loadingStop{
    [activityView stopAnimating];
    [loadingView removeFromSuperview];
    
//    for(UIView *subview in [[[[sysDege window]rootViewController]view] subviews]){
//        // remove the subview with tag equal to "9099"
//        if(subview.tag == 90999){
//            [subview removeFromSuperview];
//            NSLog(@"subview =%@",subview);
//        }
//    }
    
    
}

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
    loadingLabel.textAlignment = UITextAlignmentCenter;
    loadingLabel.text = @"連線中";
    [loadingView addSubview:loadingLabel];
    
    [[[[sysDege window]rootViewController]view] addSubview:loadingView];
    
    [activityView startAnimating];
    
    return loadingView;
}

@end
