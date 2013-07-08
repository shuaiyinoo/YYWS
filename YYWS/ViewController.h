//
//  ViewController.h
//  YYWS
//
//  Created by 帅 印 on 13-7-3.
//  Copyright (c) 2013年 三明泰格_帅 印. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    //定义界面按钮日常工作
    UIButton * dayWorkButton;
    //定义界面按钮数据分析
    UIButton * dateButton;
    //定义界面按钮促销动态
    UIButton * saleButton;
    //定义界面按钮货架管理
    UIButton * shelfButton;
    
    //定义界面按钮数据同步
    UIButton * dateSynButton;
    //定义界面按钮系统设置
    UIButton * systemSetButton;
    //定义界面按钮版本信息
    UIButton * versionInfoButton;
}

//定义响应的点击事件
-(IBAction)dayWorkButtonOnClick:(id)Sender;
-(IBAction)dateButtonOnClick:(id)Sender;
-(IBAction)saleButtonOnClick:(id)Sender;
-(IBAction)shelfButtonOnClick:(id)Sender;
-(IBAction)dateSynButtonOnClick:(id)Sender;
-(IBAction)systemSetButtonOnClick:(id)Sender;
-(IBAction)versionInfoButtonOnClick:(id)Sender;

@end
