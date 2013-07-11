//
//  ShopInfoAddViewController.h
//  YYWS
//
//  Created by 帅 印 on 13-7-11.
//  Copyright (c) 2013年 三明泰格_帅 印. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"

@interface ShopInfoAddViewController : UIViewController<PassValueDelegate>

@property (retain,nonatomic) IBOutlet UIButton *dataButton;

- (IBAction)showCalendar:(id)sender;

@end
