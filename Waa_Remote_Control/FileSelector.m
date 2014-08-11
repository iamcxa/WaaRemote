//
//  FileSelector.m
//  Waa_Remote_Control
//
//  Created by iamcxa on 2014/8/11.
//  Copyright (c) 2014年 iamcxa. All rights reserved.
//

#import "FileSelector.h"

@interface FileSelector ()

@end

@implementation FileSelector

-(void)viewDidLoad
{
    [super viewDidLoad];
    _tableview.dataSource=self;
    _tableview.delegate=self;
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //區段數量
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // 每個區段中最多有幾個列
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
     UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil)
    {
     cell=[[UITableViewCell alloc]
           initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //cell.textLabel.text=[NSString stringWithFormat:@"列＝%d",indexPath.row];
    
    
    return cell;
}



@end
