//
//  ViewSwitchController.m
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/8/23.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import "ViewSwitchController.h"
#import "ViewScanIP.h"
#import "ViewMenu.h"
#import "ViewPPT.h"
#import "ViewMusic.h"
#import "ViewVideo.h"
#import "ViewFileList.h"
#import "ViewPower.h"
#import "ViewHelp.h"
#import "toast.h"

@interface ViewSwitchController ()

@end

@implementation ViewSwitchController

@synthesize viewScanIP,viewFileList,viewMenu,viewPPT,viewMusic,viewVideo,viewPower,viewHelp;
@synthesize board;
//@synthesize navigationController;

-(void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"@viewSwitcher didLoad");
    
    board=[UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    
    viewScanIP = [board instantiateViewControllerWithIdentifier:@"ViewScanIP"];
    viewPPT = [board instantiateViewControllerWithIdentifier:@"ViewPPT"];
    viewMenu=[board instantiateViewControllerWithIdentifier:@"ViewMenu"];
    viewMusic=[board instantiateViewControllerWithIdentifier:@"ViewMusic"];
    viewVideo=[board instantiateViewControllerWithIdentifier:@"ViewVideo"];
   // viewFileList=[board instantiateViewControllerWithIdentifier:@"ViewFileList"];
    viewFileList=[[ViewFileList alloc]init];
    viewPower=[board instantiateViewControllerWithIdentifier:@"ViewPower"];
    viewHelp=[board instantiateViewControllerWithIdentifier:@"ViewHelp"];
    
//   navigationController = [[UINavigationController alloc] initWithRootViewController:self];
//    
//    navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
//    
    [self initView];
}

-(void)removeAllViews{
    NSInteger d=(self.view.subviews.count)-1;
    for(int i=0;i<d;i++){
        [[self.view.subviews objectAtIndex:i] removeFromSuperview];
    }
    //[sysDege setRootViewController];
}

-(void)initView{
    [self.view addSubview:self.viewScanIP.view];
   // [self.navigationController pushViewController:self.viewMenu animated:YES];
}

-(void)showViewMenu{
    NSLog(@"@switch=showViewMenu");
    
    //    if ([[sysDege window]rootViewController]!=[sysDege viewSwitchController]) {
    //        [[sysDege window] setRootViewController:[sysDege viewSwitchController]];
    //    }
    //[self.view addSubview:self.viewMenu.view];
    //    [self.viewScanIP
    //     performSegueWithIdentifier:@"GotoViewMenu"
    //     sender:self.viewScanIP];
    
   //[self presentViewController:self.viewMenu animated:YES completion:nil];
    
   //[self.view addSubview:self.viewMenu.view];
    
    [self.navigationController pushViewController:self.viewMenu animated:YES];
}

-(void)showViewPPT{
    NSLog(@"@switch=showViewPPT");
   //[self.view addSubview:self.viewPPT.view];
    //[self presentViewController:self.viewPPT animated:YES completion:nil];
    
   [self.navigationController pushViewController:self.viewPPT animated:YES];
}


-(void)showViewMusic{
    NSLog(@"switch=showViewMusic");
    // [self presentViewController:self.viewMusic animated:YES completion:nil];
    [self.navigationController pushViewController:self.viewMusic animated:YES];
}

-(void)showViewVideo{
    NSLog(@"switch=showViewVideo");
    // [self presentViewController:self.viewVideo animated:YES completion:nil];
    [self.navigationController pushViewController:self.viewVideo animated:YES];
}


-(void)showViewHelp{
    NSLog(@"@switch=showViewHelp");
    //[self presentViewController:self.viewHelp animated:YES completion:nil];
    [self.navigationController pushViewController:self.viewHelp animated:YES];
}

-(void)showViewPower{
    NSLog(@"@switch=showViewPower");
    // [self presentViewController:self.viewPower animated:YES completion:nil];
    [self.navigationController pushViewController:self.viewPower animated:YES];
}

-(void)showViewFileList:(NSString*)viewName{
    NSLog(@"@switch=showViewFileList=>%@",viewName);
    NSLog(@"@switch socketLastTimeResult=%@",[sysDege lastTimeSocketInputMsg]);
    //[self presentViewController:self.viewFileList animated:YES completion:nil];
    //[self.navigationController pushViewController:self.viewFileList animated:YES];
    
    if ([viewName isEqualToString:[sysDege MRCode_Show_Documents]]) {
        
        [sysDege setExec_command_tmp:[sysDege MRCode_Run_Documents]];
        //[[sysDege window] setRootViewController:self.viewPPT];
        [self.viewPPT performSegueWithIdentifier:@"GotoViewFileList" sender:viewPPT];
        
    }else if ([viewName isEqualToString:[sysDege MRCode_Show_Music]]) {
        
        [sysDege setExec_command_tmp:[sysDege MRCode_Run_Music]];
       // [[sysDege window] setRootViewController:self.viewMusic];
        [self.viewMusic performSegueWithIdentifier:@"GotoViewFileList" sender:viewMusic];
        
    }else if ([viewName isEqualToString:[sysDege MRCode_Show_Videos]]) {
        
        [sysDege setExec_command_tmp:[sysDege MRCode_Run_Videos]];
        //[[sysDege window] setRootViewController:self.viewVideo];
        [self.viewVideo performSegueWithIdentifier:@"GotoViewFileList" sender:viewVideo];
    }
}

-(void)disconnect{
    @try{
        [sysDege setSocketTypeFilter:TYPE_CODE_FIND_IP];
        [sysDege socketClose];
        [[sysDege viewSwitchController] removeAllViews];
        // [[sysDege window]setRootViewController: [sysDege viewSwitchController]];
        [[sysDege window]setRootViewController: self.navigationController];
        [[sysDege viewSwitchController] initView];
        
        [toast showInfo:@"與伺服器連線結束！"
                bgColor:[UIColor whiteColor].CGColor
                 inView:self.view
               vertical:0.7];
        
    }
    @catch (NSException *exception) {
        NSLog(@"\n\n%@\n\n",exception);
    }
}

@end

