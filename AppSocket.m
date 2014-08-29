////
////  ClientSocket.m
////  Waa_Remote_Control
////
////  Created by FuD on 2014/6/27.
////  Copyright (c) 2014年 FuD. All rights reserved.
////
//
//#import "AppSocket.h"
//
//@interface AppSocket()
//
//
//@end
//
//@implementation AppSocket
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
//            if (theStream == _inputStream) {
//                
//                NSMutableData *input = [[NSMutableData alloc] init];
//                
//                Byte buffer[1024];
//                
//                NSInteger len;
//                
//                while([_inputStream hasBytesAvailable])
//                {
//                    usleep(25000);
//                    
//                    len = [_inputStream read:buffer maxLength:1024];
//                    
//                    if (len > 0)
//                    {
//                        [input appendBytes:buffer length:len];
//                    }
//                }
//                
//                //收到的訊息
//                _socketLastTimeResult =[[NSString alloc]initWithData:input encoding:NSUTF8StringEncoding];
//                
//                event=[NSString stringWithString:_socketLastTimeResult];
//                
//                // SocketRecivedMsg=_socketRecived;
//                
//                NSLog(@"_socketType=%ld",(long)_socketTypeFilter);
//                
//                [self socketClientRespond];
//                
//                
//            }
//            
//            break;
//            
//        case NSStreamEventHasSpaceAvailable:
//            
//            event = @"NSStreamEventHasSpaceAvailable";
//            
//            if (theStream == _outputStream) {
//                
//                NSData *bytes2 = [socketOutputMsg dataUsingEncoding:NSUTF8StringEncoding];
//                Byte *Buff = (Byte *)[bytes2 bytes];
//                //输出
//                [_outputStream write:Buff maxLength:strlen((const char*)Buff)+1];
//                
//                //关闭输出流
//                [_outputStream close];
//            }
//            
//            break;
//            
//        case NSStreamEventErrorOccurred:
//            
//            event = @"NSStreamEventErrorOccurred";
//            
//            [sysDege showAlert:@"連線失敗！"];
//            
//            [self socketClose];
//            
//            break;
//            
//        case NSStreamEventEndEncountered:
//            
//            event = @"NSStreamEventEndEncountered";
//            
//            NSLog(@"Error:%ld:%@",(long)[[theStream streamError] code],
//                  
//                  [[theStream streamError] localizedDescription]);
//            
//            [sysDege showAlert:@"與伺服器連線結束！"];
//            
//            [self socketClose];
//            break;
//            
//        default:
//            
//            [self socketClose];
//            
//            event = @"Unknown";
//            
//            break;
//            
//    }
//    if (_socketLastTimeResult!=nil) {
//        NSLog(@"\n. \n _socketRecived——\"%@\"\n.", _socketLastTimeResult);
//    }else{
//        NSLog(@"\n. \n event——%@ \n.",event);
//    }
//}
//
//-(void)setEncodingSockeOutputMsg:(NSString *)Message{
//    socketOutputMsg=[Message stringByAppendingString:@"\n"];
//}
//
//-(void)socketStart:(NSString *)ServerIP
//{
//    NSLog(@"socketOutMsg=%@",socketOutputMsg);
//    if (socketOutputMsg != nil) {
//        CFReadStreamRef readStream;
//        CFWriteStreamRef writeStream;
//        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault,
//                                           (CFStringRef)CFBridgingRetain(ServerIP),
//                                           PORT,
//                                           &readStream,
//                                           &writeStream);
//        //_outputStream = (__bridge_transfer NSOutputStream*)writeStream;
//        _outputStream= (__bridge NSOutputStream *)writeStream;
//        [_outputStream setDelegate:self];
//        [_outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
//                                 forMode:NSDefaultRunLoopMode];
//        [_outputStream open];
//        _inputStream = (__bridge NSInputStream *)readStream;
//        [_inputStream setDelegate:self];
//        [_inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop]
//                                forMode:NSDefaultRunLoopMode];
//        [_inputStream open];
//    }else{
//        [self showAlert:@"socketOutMsg is nil!"];
//    }
//}
//
//-(void)socketClose
//{
//    [_outputStream close];
//    [_outputStream removeFromRunLoop:[NSRunLoop currentRunLoop]
//                             forMode:NSDefaultRunLoopMode];
//    [_outputStream setDelegate:nil];
//    [_inputStream close];
//    [_inputStream removeFromRunLoop:[NSRunLoop currentRunLoop]
//                            forMode:NSDefaultRunLoopMode];
//    [_inputStream setDelegate:nil];
//}
//
//-(void)showAlert:(NSString *)Message
//{
//    UIAlertView *alert = [[UIAlertView alloc]
//                          initWithTitle:Message
//                          message:nil
//                          delegate:self
//                          cancelButtonTitle:nil
//                          otherButtonTitles:@"OK",nil];
//    [alert show];
//    
//}
//
//-(BOOL)checkServerIpFormat:(NSString *)ServerIP
//{
//    if (![ServerIP rangeOfString:@"."].length==0) {
//        
//        NSArray *IPArray=[ServerIP componentsSeparatedByString:@"."];
//        
//        if (IPArray.count==4) {
//            
//            NSInteger IPa=[[IPArray objectAtIndex:0] integerValue];
//            NSInteger IPb=[[IPArray objectAtIndex:1] integerValue];
//            NSInteger IPc=[[IPArray objectAtIndex:2] integerValue];
//            NSInteger IPd=[[IPArray objectAtIndex:3] integerValue];
//            NSLog(@"\n.IP: %ld,%ld,%ld,%ld\n.",(long)IPa,(long)IPb,(long)IPc,(long)IPd);
//            if ((IPa<256)&&(IPa>=0)){
//                if ((IPb<256)&&(IPc>=0)){
//                    if ((IPc<256)&&(IPa>=0)){
//                        if ((IPd<256)&&(IPa>=0)){
//                            return true;
//                        }else [self showAlert:@"IP區段4格式錯誤！"];return false;
//                    }else [self showAlert:@"IP區段3格式錯誤！"];return false;
//                }else [self showAlert:@"IP區段2格式錯誤！"];return false;
//            }else [self showAlert:@"IP區段1格式錯誤！"];return false;
//        }else [self showAlert:@"IP輸入不完整！"];return false;
//    }else [self showAlert:@"IP格式錯誤！"];  return false;
//}
//
//-(void)socketClientRespond{
//    switch (_socketTypeFilter) {
//        case TYPE_CODE_FIND_IP:
//            NSLog(@"\n@ TYPE_CODE_FIND_IP @");
//            
//            [self.viewSwitchController showViewMenu];
//            
//            break;
//        case TYPE_CODE_POWERPOINT:
//            NSLog(@"\n@ TYPE_CODE_POWERPOINT @=%@",socketOutputMsg);
//            
//            
//            if ([socketOutputMsg isEqualToString:MRCode_Show_Documents]) {
//                [self.viewSwitchController showViewFileList];
//                NSLog(@"\n@ TYPE_CODE_POWERPOINT @=%@",socketOutputMsg);
//                //  }else if ([socketOutputMsg isEqualToString:MRCode_Show_Documents]){
//                
//            }
//            break;
//            
//        default:
//            break;
//    }
//}
//
//-(void)socketStartWithEncodingMsg:(NSString *)Message{
//    
//    NSLog(@"@ startSocketMsgExchange @");
//    [self setEncodingSockeOutputMsg:Message];
//    [self socketStart:[self serverIP]];
//    
//}
//
//@end
