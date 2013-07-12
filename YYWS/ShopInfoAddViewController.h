//
//  ShopInfoAddViewController.h
//  YYWS
//
//  Created by 帅 印 on 13-7-11.
//  Copyright (c) 2013年 三明泰格_帅 印. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"
@class CustomAlertView;

@interface ShopInfoAddViewController : UIViewController<PassValueDelegate>{
    //跟拍摄有关的控件
    NSMutableArray *imageArray;
    IBOutlet UIView *flashView;
    IBOutlet UIView *modeView;
    IBOutlet UIScrollView *scrollView;
    
    BOOL singleMode;    //单张拍摄
    CustomAlertView *alertView;
    int morePhotoNumber;
}

@property (retain,nonatomic) IBOutlet UIButton *dataButton;
- (IBAction)showCalendar:(id)sender;



//跟拍摄有关的方法
- (IBAction)cancel:(id)sender;
- (IBAction)takePhoto:(id)sender;
- (IBAction)setFlashMode:(UIButton *)flashBtn;
- (IBAction)captureModeChanged:(id)sender;

@end
