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
#import "ShopInfoAddViewController.h"

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
    
    //设置登录按钮
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"新增"style:UIBarButtonItemStyleDone target:self action:@selector(addShopInfoButton:)];
    shopInfo.navigationItem.rightBarButtonItem = rightButton;
    
    
    [self.navigationController pushViewController:shopInfo animated:true];
    
    //UIViewController *viewController3 = [[TabThreeViewController alloc] init];
    //viewController3.title = @"店铺情况";
    //[self.navigationController pushViewController:viewController3 animated:true];
}

-(void)addShopInfoButton:(id)sender{
    ShopInfoAddViewController *shopInfoadd = [[ShopInfoAddViewController alloc]initWithNibName:@"ShopInfoAddViewController" bundle:nil];
    shopInfoadd.title = @"店铺情况新增";
    
    //UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"上传"style:UIBarButtonItemStyleDone target:self action:@selector(addShopInfoButton:)];
    //shopInfoadd.navigationItem.rightBarButtonItem = rightButton;
    
    [self.navigationController pushViewController:shopInfoadd animated:true];
}

@end
