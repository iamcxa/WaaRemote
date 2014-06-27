//
//  ViewScanIP.m
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/8.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewScanIP.h"
#import "ClientSocket.h"

@interface ViewScanIP ()
@property (weak, nonatomic) IBOutlet UILabel *LabelServerIP;
@property (weak, nonatomic) IBOutlet UITextField *textboxServerIp;
- (IBAction)btnConnect:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *message;

//@property(weak, nonatomic)  NSMutableString *resultstring;

@end

@implementation ViewScanIP

//NSString *resultstring=nil;

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ShowAlerts:(NSString *)Message{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:Message
                          message:nil
                          delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"OK",nil];
    [alert show];
    
}

-(BOOL)CheckIP:(NSString *)ServerIP{
    
    
    if (![ServerIP rangeOfString:@"."].length==0) {
        
        NSArray *IPArray=[ServerIP componentsSeparatedByString:@"."];
        NSLog(@"IPArray.count: %d",IPArray.count);
        
        if (IPArray.count==4) {
            
            int IPa=[[IPArray objectAtIndex:0] integerValue];
            int IPb=[[IPArray objectAtIndex:1] integerValue];
            int IPc=[[IPArray objectAtIndex:2] integerValue];
            int IPd=[[IPArray objectAtIndex:3] integerValue];
            
            NSLog(@"IPa: %d",IPa);
            NSLog(@"IPb: %d",IPb);
            NSLog(@"IPc: %d",IPc);
            NSLog(@"IPd: %d",IPd);
            
            if ((IPa<256)&&(IPa>=0)){
                if ((IPb<256)&&(IPc>=0)){
                    if ((IPc<256)&&(IPa>=0)){
                        if ((IPd<256)&&(IPa>=0)){
                            
                            _clientsocket = [[ClientSocket alloc]init];
                            
                            [_clientsocket setMessage:@"Connect"];
                            
                            [_clientsocket initNetworkCommunication:ServerIP];
                            
                            return true;
                        }else [self ShowAlerts:@"IP區段4格式錯誤！"];return false;
                    }else [self ShowAlerts:@"IP區段3格式錯誤！"];return false;
                }else [self ShowAlerts:@"IP區段2格式錯誤！"];return false;
            }else [self ShowAlerts:@"IP區段1格式錯誤！"];return false;
        }else [self ShowAlerts:@"IP輸入不完整！"];return false;
    }else [self ShowAlerts:@"IP格式錯誤！"];  return false;
}

-(void)go{
    UIStoryboard *board=[UIStoryboard
                         storyboardWithName:@"Main_iPhone" bundle:nil];
    UIViewController *vc=[board instantiateViewControllerWithIdentifier:@"ViewSelect"];
//    UIViewController *vcIP=[board instantiateViewControllerWithIdentifier:@"ViewScanIP"];
//    [vcIP.view addSubview:vc.view];
//    [vcIP addChildViewController:vc];
    
    [self presentViewController:vc animated:YES completion:nil];
}

//---------------------------------------------------------//
//
//-(void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
//
//    NSString *event;
//
//    switch (streamEvent) {
//
//        case NSStreamEventNone:
//
//            event = @"NSStreamEventNone";
//
//            break;
//
//        case NSStreamEventOpenCompleted:
//
//            event = @"NSStreamEventOpenCompleted";
//
//            break;
//
//        case NSStreamEventHasBytesAvailable:
//
//            event = @"NSStreamEventHasBytesAvailable";
//
//            // if (flag ==1 && theStream == _inputStream) {
//            if (theStream == _inputStream) {
//
//                NSMutableData *input = [[NSMutableData alloc] init];
//
//                Byte buffer[1024];
//
//                int len;
//
//                while([_inputStream hasBytesAvailable])
//
//                {
//
//                    len = [_inputStream read:buffer maxLength:sizeof(buffer)];
//
//                    if (len > 0)
//
//                    {
//
//                        [input appendBytes:buffer length:len];
//
//                    }
//
//                }
//
//                resultstring =[[NSString alloc]initWithData:input encoding:NSUTF8StringEncoding];
//
//                _message.text = resultstring;
//
//                NSLog(@"resultstring:'%@'", resultstring);
//
//                if([resultstring isEqual:@"Connected"]){
//
//                    UIStoryboard *board=[UIStoryboard
//                                         storyboardWithName:@"Main_iPhone" bundle:nil];
//                    UIViewController *vc=[board instantiateViewControllerWithIdentifier:@"ViewModeSetection"];
//
//                    [self presentViewController:vc animated:YES completion:nil];
//
//                }
//
//            }
//
//            break;
//
//        case NSStreamEventHasSpaceAvailable:
//
//            event = @"NSStreamEventHasSpaceAvailable";
//
//            //if (flag ==0 && theStream == _outputStream) {
//            if (theStream == _outputStream) {
//
//                //输出
//                Byte buff2[] = "Connect\n";
//                [_outputStream write:buff2 maxLength:strlen((const char*)buff2)+1];
//
//                //关闭输出流
//                [_outputStream close];
//
//            }
//
//            break;
//
//        case NSStreamEventErrorOccurred:
//
//            event = @"NSStreamEventErrorOccurred";
//
//            [self ShowAlerts:@"連線失敗！"];
//
//            [self close];
//
//            break;
//
//        case NSStreamEventEndEncountered:
//
//            event = @"NSStreamEventEndEncountered";
//
//            NSLog(@"Error:%d:%@",[[theStream streamError] code],
//
//                  [[theStream streamError] localizedDescription]);
//
//            [self ShowAlerts:@"與伺服器連線結束！"];
//
//            break;
//
//        default:
//
//            [self close];
//
//            event = @"Unknown";
//
//            break;
//
//    }
//
//    NSLog(@"event——%@",event);
//
//}
//
//- (void)initNetworkCommunication:(NSString *)ServerIP
//
//{
//
//    CFReadStreamRef readStream;
//
//    CFWriteStreamRef writeStream;
//
//    CFStreamCreatePairWithSocketToHost(NULL,
//                                       (CFStringRef)CFBridgingRetain(ServerIP), PORT, &readStream, &writeStream);
//
//    _inputStream = (__bridge_transfer NSInputStream *)readStream;
//
//    _outputStream = (__bridge_transfer NSOutputStream*)writeStream;
//
//    [_inputStream setDelegate:self];
//
//    [_outputStream setDelegate:self];
//
//    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
//
//                            forMode:NSDefaultRunLoopMode];
//
//    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
//
//                             forMode:NSDefaultRunLoopMode];
//
//    [_inputStream open];
//
//    [_outputStream open];
//
//}
//
//
///* 点击发送按钮  */
//
///*
// - (IBAction)sendData:(id)sender {
//
// flag = 0;
//
// [self initNetworkCommunication];
//
// }c
// */
//
///* 点击接收按钮  */
//
///*
// - (IBAction)receiveData:(id)sender {
//
// flag = 1;
//
// [self initNetworkCommunication];
//
// }
// */
//
//-(void)close
//
//{
//
//    [_outputStream close];
//
//    [_outputStream removeFromRunLoop:[NSRunLoop currentRunLoop]
//
//                             forMode:NSDefaultRunLoopMode];
//
//    [_outputStream setDelegate:nil];
//
//    [_inputStream close];
//
//    [_inputStream removeFromRunLoop:[NSRunLoop currentRunLoop]
//
//                            forMode:NSDefaultRunLoopMode];
//
//    [_inputStream setDelegate:nil];
//
//}

//---------------------------------------------------------//


//---------------------------------------------------------//


- (IBAction)btnConnect:(id)sender
{
    NSString *ServerIP=self.textboxServerIp.text;
    
    if([self CheckIP:ServerIP]){
        
    }
    
}

- (IBAction)textboxServerIp:(id)sender {
}

-(BOOL)validateServerIP:(NSString *)ServerIP{
    NSString *regex=@"[0-9]{1,3}";
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicate evaluateWithObject:ServerIP];
}






@end
