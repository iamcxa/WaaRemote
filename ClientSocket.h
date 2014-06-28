//
//  ClientSocket.h
//  Waa_Remote_Control
//
//  Created by FuD on 2014/6/27.
//  Copyright (c) 2014年 FuD. All rights reserved.
//

#import <Foundation/Foundation.h>


#include <sys/socket.h>
#include <netinet/in.h>

#define PORT 3579


@interface ClientSocket : UIViewController<NSStreamDelegate>

- (void)initNetworkCommunication:(NSString *)ServerIP ;

-(void) setSocketMessage:(NSString *)SocketMsg;

@property (nonatomic, retain) NSInputStream *inputStream;

@property (nonatomic, retain) NSOutputStream *outputStream;

@end
