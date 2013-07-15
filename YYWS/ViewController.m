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
#import "JKCustomAlert.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setBool:false forKey:@"isLogin"];
    [defaults setBool:true forKey:@"isLogin"];
    [defaults synchronize];//用synchronize方法把数据持久化到standardUserDefaults数据库
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    switch ([defaults integerForKey:(@"loginType")]) {
        case 1:{
            DayWorkViewController *dayWork = [[DayWorkViewController alloc]initWithNibName:@"DayWorkViewController" bundle:nil];
            dayWork.title = @"日常工作";
            [self.navigationController pushViewController:dayWork animated:true];
        }
            break;
    }
}

//定义界面按钮日常工作
-(IBAction)dayWorkButtonOnClick:(id)Sender{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    if(![defaults boolForKey:(@"isLogin")]){
        [defaults setInteger:1 forKey:(@"loginType")];
        [defaults synchronize];//用synchronize方法把数据持久化到standardUserDefaults数据库
        [self showLogin];
    }else{
        DayWorkViewController *dayWork = [[DayWorkViewController alloc]initWithNibName:@"DayWorkViewController" bundle:nil];
        dayWork.title = @"日常工作";
        
        [self.navigationController pushViewController:dayWork animated:true];
    }
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
- (void)showLogin{
    UIImage *backgroundImage = [UIImage imageNamed:@"boxbg.png"];
    
    UIGraphicsBeginImageContext(CGSizeMake(280, 320));
    [backgroundImage drawInRect:CGRectMake(0, 0, 280, 250)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [btn1 setImage:[UIImage imageNamed:@"login1.png"] forState:UIControlStateHighlighted];
    [btn1 setFrame:CGRectMake(65, 180, 160, 48)];
    
    UITextField* userName = [[UITextField alloc] initWithFrame:CGRectMake(50, 60, 200, 35)];
    userName.borderStyle = UITextBorderStyleRoundedRect;
    userName.autocorrectionType = UITextAutocorrectionTypeYes;
    userName.placeholder = @"请输入用户编码";
    userName.returnKeyType = UIReturnKeyDone;
    userName.clearButtonMode = UITextFieldViewModeWhileEditing;
    userName.keyboardType = UIKeyboardTypeNumberPad;
    userName.textAlignment = UITextAlignmentLeft;
    userName.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UITextField* passWord = [[UITextField alloc] initWithFrame:CGRectMake(50, 110, 200, 35)];
    passWord.borderStyle = UITextBorderStyleRoundedRect;
    passWord.autocorrectionType = UITextAutocorrectionTypeYes;
    passWord.placeholder = @"请输入用户密码";
    passWord.returnKeyType = UIReturnKeyDone;
    passWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    passWord.keyboardType = UIKeyboardTypeNumberPad;
    passWord.textAlignment = UITextAlignmentLeft;
    passWord.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    passWord.secureTextEntry = YES;
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    userName.text = ![defaults objectForKey:@"userName"]?@"":[defaults objectForKey:@"userName"];
    passWord.text = ![defaults objectForKey:@"passWord"]?@"":[defaults objectForKey:@"passWord"];
    
    JKCustomAlert * alert = [[JKCustomAlert alloc] initWithImage:reSizeImage];
    alert.JKdelegate = self;
    alert.delegate = self;
    [alert addButtonWithUIButton:btn1];
    [alert addUserNameWithUITextField:userName];
    [alert addPassWordWithUITextField:passWord];
    [alert show];
}

@end
