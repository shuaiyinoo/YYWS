//
//  ShopInfoAddViewController.m
//  YYWS
//
//  Created by 帅 印 on 13-7-11.
//  Copyright (c) 2013年 三明泰格_帅 印. All rights reserved.
//

#import "ShopInfoAddViewController.h"
#import "VRGViewController.h"

@interface ShopInfoAddViewController ()

@end

@implementation ShopInfoAddViewController

@synthesize dataButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//显示日期选择控件
- (IBAction)showCalendar:(id)sender{
    VRGViewController *VRG = [[VRGViewController alloc] initWithNibName:@"VRGViewController" bundle:[NSBundle mainBundle]];
    VRG.delegate = self;
    //跳转界面
    [self presentModalViewController:VRG animated:YES];
}

//协议回调
//实现协议，在第一个窗口显示在第二个窗口输入的值，类似Android中的onActivityResult方法
-(void)passValue:(NSString *)value
{
    [dataButton setTitle:value forState:UIControlStateNormal];
}

@end
