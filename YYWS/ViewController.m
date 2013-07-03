//
//  ViewController.m
//  YYWS
//
//  Created by 帅 印 on 13-7-3.
//  Copyright (c) 2013年 三明泰格_帅 印. All rights reserved.
//

#import "ViewController.h"
#import "DateSynViewController.h"
#import "SystemSetViewController.h"
#import "VersionInfoViewController.h"
#import "DayWorkViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


//定义界面按钮日常工作
-(IBAction)dayWorkButtonOnClick:(id)Sender{
    DayWorkViewController *dayWork = [[DayWorkViewController alloc]initWithNibName:@"DayWorkViewController" bundle:nil];
    dayWork.title = @"日常工作";
    
    [self.navigationController pushViewController:dayWork animated:true];
}
//定义界面按钮数据分析
-(IBAction)dateButtonOnClick:(id)Sender{
    
}
//定义界面按钮促销动态
-(IBAction)saleButtonOnClick:(id)Sender{
    
}
//定义界面按钮货架管理
-(IBAction)shelfButtonOnClick:(id)Sender{
    
}
//定义界面按钮数据同步
-(IBAction)dateSynButtonOnClick:(id)Sender{
    DateSynViewController *datesyn = [[DateSynViewController alloc]initWithNibName:@"DateSynViewController" bundle:nil];
    datesyn.title = @"数据同步";
    
    [self.navigationController pushViewController:datesyn animated:true];
}
//定义界面按钮系统设置
-(IBAction)systemSetButtonOnClick:(id)Sender{
    SystemSetViewController *systemSet = [[SystemSetViewController alloc]initWithNibName:@"SystemSetViewController" bundle:nil];
    systemSet.title = @"系统设置";
    
    [self.navigationController pushViewController:systemSet animated:true];
}
//定义界面按钮版本信息
-(IBAction)versionInfoButtonOnClick:(id)Sender{
    VersionInfoViewController *verion = [[VersionInfoViewController alloc]initWithNibName:@"VersionInfoViewController" bundle:nil];
    verion.title = @"版本信息";
    
    [self.navigationController pushViewController:verion animated:true];
}
@end
