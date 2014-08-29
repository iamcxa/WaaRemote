//
//  FileSelector.h
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/8/11.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewFileList : UITableViewController//<UITableViewDelegate,UITableViewDataSource>


@property (strong,nonatomic) NSArray * listData;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property (nonatomic,retain) NSMutableArray *seleteData;

@property NSString* FileList;



@end
