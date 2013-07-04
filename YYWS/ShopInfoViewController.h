//
//  ShopInfoViewController.h
//  YYWS
//
//  Created by 帅 印 on 13-7-4.
//  Copyright (c) 2013年 三明泰格_帅 印. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceHelper.h"

@interface ShopInfoViewController : UIViewController<UITableViewDelegate, UITableViewDataSource,ServiceHelperDelegate>{
    //请求登录对象
    ServiceHelper *helper;
    
    IBOutlet UITableView *shopinfoTableView;
}

@property (strong, nonatomic) NSDictionary *shopInfoData;

@end
