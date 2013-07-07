//
//  ShopInfoViewController.h
//  YYWS
//
//  Created by 帅 印 on 13-7-4.
//  Copyright (c) 2013年 三明泰格_帅 印. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceHelper.h"
#import "PullingRefreshTableView.h"
#import "PMCalendar.h"

@interface ShopInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,ServiceHelperDelegate,PullingRefreshTableViewDelegate,PMCalendarControllerDelegate>{
    //请求登录对象
    ServiceHelper *helper;
    
    
}

@property (retain,nonatomic) PullingRefreshTableView *shopinfoTableView;
@property (retain,nonatomic) NSMutableArray *shopInfoData;//存放的数据
@property (nonatomic) BOOL refreshing;//是否刷新
@property (assign,nonatomic) NSInteger page;//当前页面

//条件
@property (retain,nonatomic) IBOutlet UITextField *shopcodeTextField;
@property (retain,nonatomic) IBOutlet UITextField *dataTextField;

- (IBAction)showCalendar:(id)sender;
@end
