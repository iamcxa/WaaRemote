//
//  ViewController.h
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/8.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <sys/socket.h>
#include <netinet/in.h>

#define PORT 3579


@interface ViewController : UIViewController<NSStreamDelegate>
{
    int flag;
}



@property (nonatomic, retain) NSInputStream *inputStream;

@property (nonatomic, retain) NSOutputStream *outputStream;



@end
