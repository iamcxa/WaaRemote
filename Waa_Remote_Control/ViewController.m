//
//  ViewController.m
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/8.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *LabelServerIP;
@property (weak, nonatomic) IBOutlet UITextField *textboxServerIp;
- (IBAction)btnConnect:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *message;


@end

@implementation ViewController

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
                            
                            [self initNetworkCommunication:ServerIP];
                            
                            return true;
                        }else [self ShowAlerts:@"IP區段4格式錯誤！"];return false;
                    }else [self ShowAlerts:@"IP區段3格式錯誤！"];return false;
                }else [self ShowAlerts:@"IP區段2格式錯誤！"];return false;
            }else [self ShowAlerts:@"IP區段1格式錯誤！"];return false;
        }else [self ShowAlerts:@"IP輸入不完整！"];return false;
    }else [self ShowAlerts:@"IP格式錯誤！"];  return false;
}

-(void)ConnectSocket{
    
}

//---------------------------------------------------------//

-(void)stream:(NSStream *)theStream handleEvent:(NSStreamEvent)streamEvent {
    
    NSString *event;
    
    switch (streamEvent) {
            
        case NSStreamEventNone:
            
            event = @"NSStreamEventNone";
            
            break;
            
        case NSStreamEventOpenCompleted:
            
            event = @"NSStreamEventOpenCompleted";
            
            break;
            
        case NSStreamEventHasBytesAvailable:
            
            event = @"NSStreamEventHasBytesAvailable";
            
           // if (flag ==1 && theStream == _inputStream) {
                if (theStream == _inputStream) {
                
                NSMutableData *input = [[NSMutableData alloc] init];
                
                uint8_t buffer[1024];
                
                int len;
                
                while([_inputStream hasBytesAvailable])
                    
                {
                    
                    len = [_inputStream read:buffer maxLength:sizeof(buffer)];
                    
                    if (len > 0)
                        
                    {
                        
                        [input appendBytes:buffer length:len];
                        
                    }
                    
                }
                
                NSString *resultstring = [[NSString alloc]
                                          
                                          initWithData:input encoding:NSUTF8StringEncoding];
                
                NSLog(@"接收:%@",resultstring);
                
                _message.text = resultstring;
                
            }
            
            break;
            
        case NSStreamEventHasSpaceAvailable:
            
            event = @"NSStreamEventHasSpaceAvailable";
            
            //if (flag ==0 && theStream == _outputStream) {
                if (theStream == _outputStream) {
                
                //输出
                
               // NSData *_dataToSend = [NSData dataWithBytes:"123456" length:20];  //可用 後面的 length:20 好像不會影響
                //[_outputStream write:[_dataToSend bytes] maxLength:[_dataToSend length]];
                
                //uint8_t buff[] = "MRCode_CC"; //不可用
                //[_outputStream write:buff maxLength: strlen((const char*)buff)+1];
                
                
                Byte buff2[] = "MRCode_CC_01\n";  //可用
                [_outputStream write:buff2 maxLength:strlen((const char*)buff2)+1];
                
                // [self ShowAlerts:@"Hello Server!"];
                
                //关闭输出流
                [_outputStream close];
                
            }
            
            break;
            
        case NSStreamEventErrorOccurred:
            
            event = @"NSStreamEventErrorOccurred";
            
            [self close];
            
            break;
            
        case NSStreamEventEndEncountered:
            
            event = @"NSStreamEventEndEncountered";
            
            NSLog(@"Error:%d:%@",[[theStream streamError] code],
                  
                  [[theStream streamError] localizedDescription]);
            
            break;
            
        default:
            
            [self close];
            
            event = @"Unknown";
            
            break;
            
    }
    
    NSLog(@"event——%@",event);
    
}

- (void)initNetworkCommunication:(NSString *)ServerIP

{
    
    CFReadStreamRef readStream;
    
    CFWriteStreamRef writeStream;
    
    CFStreamCreatePairWithSocketToHost(NULL,
                                       (CFStringRef)CFBridgingRetain(ServerIP), PORT, &readStream, &writeStream);
    
    _inputStream = (__bridge_transfer NSInputStream *)readStream;
    
    _outputStream = (__bridge_transfer NSOutputStream*)writeStream;
    
    [_inputStream setDelegate:self];
    
    [_outputStream setDelegate:self];
    
    [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
     
                            forMode:NSDefaultRunLoopMode];
    
    [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
     
                             forMode:NSDefaultRunLoopMode];
    
    [_inputStream open];
    
    [_outputStream open];
    
}


/* 点击发送按钮  */

/*
 - (IBAction)sendData:(id)sender {
 
 flag = 0;
 
 [self initNetworkCommunication];
 
 }c
 */

/* 点击接收按钮  */

/*
 - (IBAction)receiveData:(id)sender {
 
 flag = 1;
 
 [self initNetworkCommunication];
 
 }
 */

-(void)close

{
    
    [_outputStream close];
    
    [_outputStream removeFromRunLoop:[NSRunLoop currentRunLoop]
     
                             forMode:NSDefaultRunLoopMode];
    
    [_outputStream setDelegate:nil];
    
    [_inputStream close];
    
    [_inputStream removeFromRunLoop:[NSRunLoop currentRunLoop]
     
                            forMode:NSDefaultRunLoopMode];
    
    [_inputStream setDelegate:nil];
    
}

//---------------------------------------------------------//


//---------------------------------------------------------//


- (IBAction)btnConnect:(id)sender
{
    
    NSString *ServerIP=self.textboxServerIp.text;
    
    if ([self CheckIP:ServerIP]) {
        //[self ShowAlerts:@"IP驗證成功！"];
        
    }else{
        [self ShowAlerts:@"IP驗證失敗！"];
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
