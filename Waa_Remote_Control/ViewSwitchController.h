//
//  ViewSwitchController.h
//  ;
//
//  Created by iamcxa on 2014/8/23.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewSwitchController;
@class ViewMenu;
@class ViewFileList;
@class ViewScanIP;
@class ViewPPT;
@class ViewMusic;
@class ViewVideo;
@class ViewPower;
@class ViewHelp;

@interface ViewSwitchController : UIViewController{
//    ViewScanIP *viewScanIP;
//    ViewMenu *viewMenu;
//    ViewPPT *viewPPT;
//    ViewFileList *viewFileList;
//    ViewVideo *viewVideo;
//    ViewMusic *viewMusic;
//    UIStoryboard *board;
//    UINavigationController *navigationController;
}

@property (nonatomic,retain) UIStoryboard *board;
//@property (nonatomic,strong) UINavigationController *navigationController;
@property (nonatomic,strong) ViewScanIP *viewScanIP;
@property (nonatomic,strong) ViewPPT *viewPPT;
@property (nonatomic,strong) ViewMenu *viewMenu;
@property (nonatomic,strong) ViewFileList *viewFileList;
@property (nonatomic,strong) ViewVideo *viewVideo;
@property (nonatomic,strong) ViewMusic *viewMusic;
@property (nonatomic,strong) ViewPower *viewPower;
@property (nonatomic,strong) ViewHelp *viewHelp;

-(void)disconnect;
-(void)removeAllViews;
-(void)initView;
-(void)showViewPPT;
-(void)showViewHelp;
-(void)showViewMenu;
-(void)showViewMusic;
-(void)showViewVideo;
-(void)showViewPower;
-(void)showViewFileList:(NSString*)viewName;

@end
