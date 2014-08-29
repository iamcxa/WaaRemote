////
////  ClientSocket.h
////  Waa_Remote_Control
////
////  Created by FuD on 2014/6/27.
////  Copyright (c) 2014年 FuD. All rights reserved.
////
//
//#import <UIKit/UIKit.h>
//
//#include <sys/socket.h>
//#include <netinet/in.h>
//
//#define PORT 3579
//#define TYPE_CODE_FIND_IP 0
//
//#define TYPE_CODE_POWERPOINT 100
//#define TYPE_CODE_VIDEO 200
//#define TYPE_CODE_POWER 300
//#define TYPE_CODE_MUSIC 400
//
//static int socketType=0;
//
//@interface AppSocket : UIViewController<NSStreamDelegate>
//
//@property (nonatomic,retain) NSInputStream *inputStream;
//@property (nonatomic,retain) NSOutputStream *outputStream;
//
//@property (nonatomic,retain) NSMutableArray *fileSelectedList;
//@property NSInteger fileSelectedRow;
//
//@property (nonatomic,retain) NSString *socketLastTimeResult;
//@property NSInteger socketTypeFilter;
//@property (nonatomic,retain) NSString *serverIP;
//
//
//-(void)socketStartWithEncodingMsg:(NSString *)Message;
//-(void)socketClose;
//-(BOOL)checkServerIpFormat:(NSString *)ServerIP;
//
//@end
