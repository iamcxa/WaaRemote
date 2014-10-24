//
//  ViewSelect.m
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/6/8.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//
#import "ViewMenu.h"
#import "ViewSwitchController.h"



@implementation ViewMenu

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

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

- (IBAction)btnPowerPoint:(id)sender
{
    [[sysDege viewSwitchController]showViewPPT];
}

- (IBAction)btnPower:(id)sender
{
    
    [[sysDege viewSwitchController]showViewPower];
}

- (IBAction)btnHelp:(id)sender
{
    [[sysDege viewSwitchController]showViewHelp];
}

- (IBAction)btnVideo:(id)sender
{
    [[sysDege viewSwitchController]showViewVideo];
}

- (IBAction)btnMusic:(id)sender
{
    [[sysDege viewSwitchController]showViewMusic];
}

-(void)setSocketMsg:(NSString *)Message{
    _labelSocketMsg.text=Message;
}


@end
