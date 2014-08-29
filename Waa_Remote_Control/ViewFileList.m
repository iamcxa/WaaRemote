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

@implementation ViewFileList

@synthesize tableview;

-(void)viewDidLoad
{
    [super viewDidLoad];
    FileList=@"回上頁//s";
    FileList=[FileList stringByAppendingString:[sysDege socketLastTimeResult]];
    NSArray *fileListArray =[FileList componentsSeparatedByString:@"//s"];
    FileListMutableArray = [NSMutableArray arrayWithArray:fileListArray];
    NSLog(@"FileListMutableArray=%@",FileListMutableArray);
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //區段數量
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 每個區段中最多有幾個列
    NSLog(@"@FileListArray.count=%lu",(unsigned long)FileListMutableArray.count-1);
    return FileListMutableArray.count-1;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger row=[indexPath row];
    if (row!=0) {
        //[sysDege setFileSelectedList:[FileListArray objectAtIndex:row ]];
        
        [sysDege setFileSelectedList:FileListMutableArray];
        
        [sysDege setFileSelectedRow:row];
        
        NSLog(@"selectedFileName=%@",[[sysDege fileSelectedList]objectAtIndex:[sysDege fileSelectedRow]]);
        
        NSString *cmd=[sysDege exec_command_tmp];
        cmd=[cmd stringByAppendingString:@"//s"];
        
        cmd=[cmd stringByAppendingString:[[sysDege fileSelectedList]objectAtIndex:[sysDege fileSelectedRow]]];
        
        [sysDege setLastTimeUsedCmd:cmd];
        
        [sysDege socketStartWithMessage:cmd];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
