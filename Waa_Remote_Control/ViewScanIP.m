//
//  ViewScanIP.m
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/8.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//
#import "ViewScanIP.h"
#import "toast.h"

@interface ViewScanIP ()


@end

@implementation ViewScanIP



- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"@IPScnaer didLoad");
    if ([sysDege lastTimeUsedServerIP]!=nil){
        NSLog(@"@lastTimeUsedServerIP found=>%@",[sysDege lastTimeUsedServerIP]);
        self.textboxServerIp.text=[sysDege lastTimeUsedServerIP];
    }
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnConnect:(id)sender
{
    NSString *serverIP=self.textboxServerIp.text;
    NSLog(@"@inputIP=%@",serverIP);
    
    if([sysDege checkServerIpFormat:serverIP]){
        
        [sysDege setServerIP:serverIP];
        [sysDege setSocketTypeFilter:TYPE_CODE_FIND_IP];
        [sysDege socketStartWithMessage:[sysDege MRCode_Connect]];
        
    }
}

- (IBAction)textboxServerIp:(id)sender {
    
}


-(void)setSocketMsg:(NSString *)Message{
    _labelSocketMsg.text=Message;
}



//-(void)checkSocketStatue{
//    NSLog(@"[Common socketLastTimeResult]=%@",[sysDege socketLastTimeResult]);
//    if ([[sysDege socketLastTimeResult] isEqualToString:@"Connected"]) {
//        [self performSegueWithIdentifier:@"GotoViewMenu" sender:self];
//
//    }
//}
//
//-(void)MoveToNextView{
//    UIStoryboard *board=[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
//    UIViewController *vc=[board instantiateViewControllerWithIdentifier:@"ViewSelect"];
//    [[[sysDege window] rootViewController] presentViewController:vc animated:YES completion:nil];
//}




@end
