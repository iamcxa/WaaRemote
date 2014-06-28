//
//  ViewPowerpoint.m
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/25.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import "ViewPowerpoint.h"
#import "ClientSocket.h"
#import "Common.h"

@interface ViewPowerpoint ()

@end

@implementation ViewPowerpoint

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)LetDoIt:(NSString *)Command{
   // Common *Variable=[[Common alloc]init];
    _clientsocket = [[ClientSocket alloc]init];
    [_clientsocket setSocketMessage:Command];
    [_clientsocket initNetworkCommunication:ServerIP];
    
    NSLog(@"Command:%@",Command);
    NSLog(@"IP:%@",ServerIP);
}

- (IBAction)btnHome:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)btnVolumeUp:(id)sender {
    //[self LetDoIt:@"MRCode_PPT_14"];
    [self LetDoIt:@"MRCode_PPT_14"];
}

- (IBAction)btnVolumeDown:(id)sender {
   [self LetDoIt:@"MRCode_PPT_15"];
}

- (IBAction)btnPageBack:(id)sender {
    [self LetDoIt:@"MRCode_PPT_12"];
}

- (IBAction)btnPageNext:(id)sender {
       [self LetDoIt:@"MRCode_PPT_13"];
}

- (IBAction)btnAction:(id)sender {
    [self LetDoIt:@"MRCode_PPT_10"];
}

- (IBAction)btnFilelist:(id)sender {
}

- (IBAction)btnTimeAdd:(id)sender {
}

- (IBAction)btnTimeReduce:(id)sender {
}
@end
