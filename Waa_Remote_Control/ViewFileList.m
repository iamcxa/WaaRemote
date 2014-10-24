//
//  FileSelector.m
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/8/11.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import "ViewFileList.h"
#import "ViewPPT.h"
#import "ViewSwitchController.h"

#import "ViewMenu.h"

@interface ViewFileList ()

@end

NSString *Result;
NSString *FileList;
NSString *data;
NSMutableArray *FileListMutableArray;
ViewMenu *viewMenu;
ViewPPT *viewPPT;

@implementation ViewFileList

@synthesize tableview;

-(void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"@ViewFileList didLoad");
    
    FileList=@"回上頁//s";
    
    NSLog(@"@ViewFileList lastTimeSocketInputMsg=%@",[sysDege lastTimeSocketInputMsg]);
    
    FileList=[FileList stringByAppendingString:[sysDege lastTimeSocketInputMsg]];
    NSArray *fileListArray =[FileList componentsSeparatedByString:@"//s"];
    
    FileListMutableArray = [NSMutableArray arrayWithArray:fileListArray];
    NSLog(@"FileListMutableArray=%@",FileListMutableArray);
    
}

-(void)setCompont{
    //为了多选
    self.tableview.allowsSelection=YES;
    self.tableview.allowsSelectionDuringEditing=YES;
    //直接让tableView处于编辑状态
    [self.tableview setEditing:YES animated:YES];
    //设置tableView无分割线
    self.tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableview.backgroundColor=[UIColor clearColor];
    //tableView显示大小
    //self.tableview.frame=CGRectMake(50, 50, 220, 300);
    //垂直方向滑块取消
    //self.tableview.showsVerticalScrollIndicator=NO;
    //tableView总大小
    //self.tableview.contentSize=CGSizeMake(220, 300);
    //边界无回弹
    self.tableview.bounces=NO;
    
    tableview.dataSource=self;
    tableview.delegate=self;
}

-(void)setFileType:(NSString *)fileType{
    
    switch ([sysDege socketTypeFilter]) {
            
        case TYPE_CODE_POWERPOINT:
            
            [sysDege socketStartWithMessage:@"MRCode_Show_Documents"];
            
            break;
            
        case TYPE_CODE_MUSIC:
            
            [sysDege socketStartWithMessage:@"MRCode_Show_Music"];
            
            break;
            
        case TYPE_CODE_VIDEO:
            
            [sysDege socketStartWithMessage:@"MRCode_Show_Videos"];
            
            break;
            
        default:
            
            [sysDege showAlert:@"檔案篩選錯誤！"];
            
            break;
    }
}

//區段數量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

// 每個區段中最多有幾個列
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"@FileListArray.count=%lu",(unsigned long)FileListMutableArray.count-1);
    return FileListMutableArray.count-1;
}

// 編輯畫面設定
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //不要显示任何编辑的图标
    return UITableViewCellEditingStyleNone;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (indexPath.row==0) {
        [cell setAccessoryType:UITableViewCellAccessoryDetailButton];
        UIColor *uiblue=[UIColor whiteColor];
        [cell setBackgroundColor:uiblue];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    }else{
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
    
    [cell setMultipleTouchEnabled:YES];
    cell.textLabel.text=[NSString stringWithFormat:@"%@",FileListMutableArray[indexPath.row]];
    
    return cell;
}

// 列點選後
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger row=[indexPath row];
  //  [self.navigationController popViewControllerAnimated:YES];
    
    if (row!=0) {
        //[sysDege setFileSelectedList:[FileListArray objectAtIndex:row ]];
        
        [sysDege setSelectedFileList:FileListMutableArray];
        
        [sysDege setSelectedFileRow:row];
        
        [sysDege setSelectedFileName:[[sysDege selectedFileList]objectAtIndex:[sysDege selectedFileRow]]];
        
        NSLog(@"selectedFileName=%@",[sysDege selectedFileName]);
        
        NSString *cmd=[sysDege exec_command_tmp];
        
        cmd=[cmd stringByAppendingString:@"//s"];
        
        cmd=[cmd stringByAppendingString:
             [[sysDege selectedFileList]objectAtIndex:[sysDege selectedFileRow]]];
        
        [sysDege setLastTimeUsedCmd:cmd];
        
        [sysDege socketStartWithMessage:cmd];
        
        [sysDege setLastTimeSocketInputMsg:nil];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
