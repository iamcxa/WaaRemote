//
//  ClientSocket.m
//  Waa_Remote_Control
//
//  Created by FuD on 2014/6/27.
//  Copyright (c) 2014年 FuD. All rights reserved.
//

#import "ClientSocket.h"
#import "ViewScanIP.h"

@implementation ClientSocket

NSString *resultstring=nil;
NSString *Msg=nil;
//---------------------------------------------------------//

-(void)ShowAlerts:(NSString *)Message{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:Message
                          message:nil
                          delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:@"OK",nil];
    [alert show];
    
}

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
                
                Byte buffer[1024];
                
                int len;
                
                while([_inputStream hasBytesAvailable])
                    
                {
                    
                    len = [_inputStream read:buffer maxLength:sizeof(buffer)];
                    
                    if (len > 0)
                        
                    {
                        
                        [input appendBytes:buffer length:len];
                        
                    }
                    
                }
                
                resultstring =[[NSString alloc]initWithData:input encoding:NSUTF8StringEncoding];
                
                [self ShowAlerts:resultstring];

//                _message.text = resultstring;
                
                NSLog(@"resultstring:'%@'", resultstring);
                
                if([resultstring isEqual:@"Connected"]){
                    @try {
                        
                        ViewScanIP *vsip= [[ViewScanIP alloc]init];
                        [vsip go];
                    }
                    @catch (NSException *exception) {
                        NSLog(@"%@",exception);
                    }
                    
                }
                
            }
            
            break;
            
        case NSStreamEventHasSpaceAvailable:
            
            event = @"NSStreamEventHasSpaceAvailable";
            
            //if (flag ==0 && theStream == _outputStream) {
            if (theStream == _outputStream) {
                
                NSData *bytes2 = [Msg dataUsingEncoding:NSUTF8StringEncoding];
                Byte *Buff = (Byte *)[bytes2 bytes];
                //输出
                [_outputStream write:Buff maxLength:strlen((const char*)Buff)+1];
                
                //关闭输出流
                [_outputStream close];
                
            }
            
            break;
            
        case NSStreamEventErrorOccurred:
            
            event = @"NSStreamEventErrorOccurred";
            
            [self ShowAlerts:@"連線失敗！"];
            
            [self close];
            
            break;
            
        case NSStreamEventEndEncountered:
            
            event = @"NSStreamEventEndEncountered";
            
            NSLog(@"Error:%d:%@",[[theStream streamError] code],
                  
                  [[theStream streamError] localizedDescription]);
            
            [self ShowAlerts:@"與伺服器連線結束！"];
            
            break;
            
        default:
            
            [self close];
            
            event = @"Unknown";
            
            break;
            
    }
    
    NSLog(@"event——%@",event);
    
}

-(void) setMessage:(NSString *)Message2{
    Msg=[Message2 stringByAppendingString:@"\n"];
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
    
    NSLog(@"連接成功");
    
    
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




@end
