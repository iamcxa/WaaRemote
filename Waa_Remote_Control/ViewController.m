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
            
            if ((IPa<256)&&(IPa>0)){
                if ((IPb<256)&&(IPc>0)){
                    if ((IPc<256)&&(IPa>0)){
                        if ((IPd<256)&&(IPa>0)){
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


- (IBAction)btnConnect:(id)sender
{
    
 NSString *ServerIP=self.textboxServerIp.text;
    
    if ([self CheckIP:ServerIP]) {
        [self ShowAlerts:@"IP驗證成功！"];
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
