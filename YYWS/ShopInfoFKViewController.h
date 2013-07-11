//
//  ShopInfoFKViewController.h
//  YYWS
//
//  Created by 帅 印 on 13-7-5.
//  Copyright (c) 2013年 三明泰格_帅 印. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopInfoEntity.h"
#import "EScrollerView.h"

@interface ShopInfoFKViewController : UIViewController<EScrollerViewDelegate>{
    IBOutlet UIPageControl *page;
}

@property (retain,nonatomic) ShopInfoEntity *shopInfoEntity;

@property (retain,nonatomic) IBOutlet UILabel *shopInfoEntityTitle;
@property (retain,nonatomic) IBOutlet UILabel *shopInfoEntityInfo;
@property (retain,nonatomic) IBOutlet UITextView *shopInfoEntityCount;

@end
