//
//  ViewScanIP.h
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/8.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ClientSocket.h"
//#include <sys/socket.h>
//#include <netinet/in.h>
//
//#define PORT 3579


@interface ViewScanIP : UIViewController<NSStreamDelegate>
{
    int flag;
}

-(void)go;

@property (weak, nonatomic) IBOutlet UIButton *hhh;

@property (retain, nonatomic)ClientSocket *clientsocket;
//@property (nonatomic, retain) NSInputStream *inputStream;
//
//@property (nonatomic, retain) NSOutputStream *outputStream;
//
//
//


@end
