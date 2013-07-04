//
//  DayWorkViewController.m
//  YYWS
//
//  Created by 帅 印 on 13-7-3.
//  Copyright (c) 2013年 三明泰格_帅 印. All rights reserved.
//

#import "DayWorkViewController.h"
#import "ShopInfoViewController.h"
#import "DIYTableViewController.h"
#import "TabThreeViewController.h"

@interface DayWorkViewController ()

@end

@implementation DayWorkViewController

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

//点击店铺情况时候的跳转
-(IBAction)shipInfoButtonOnClick:(id)Sender{
    ShopInfoViewController *shopInfo = [[ShopInfoViewController alloc]initWithNibName:@"ShopInfoViewController" bundle:nil];
    shopInfo.title = @"店铺情况";
    
    [self.navigationController pushViewController:shopInfo animated:true];
    
    //UIViewController *viewController3 = [[TabThreeViewController alloc] init];
    //viewController3.title = @"店铺情况";
    //[self.navigationController pushViewController:viewController3 animated:true];
}

@end
