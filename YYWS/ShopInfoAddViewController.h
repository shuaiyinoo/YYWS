//
//  ShopInfoAddViewController.h
//  YYWS
//
//  Created by 帅 印 on 13-7-11.
//  Copyright (c) 2013年 三明泰格_帅 印. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassValueDelegate.h"
#import "ServiceHelper.h"
@class CustomAlertView;

@interface ShopInfoAddViewController : UIViewController<PassValueDelegate,ServiceHelperDelegate>{
    //跟拍摄有关的控件
    NSMutableArray *imageArray;
    IBOutlet UIView *flashView;
    IBOutlet UIView *modeView;
    IBOutlet UIScrollView *scrollView;
    
    BOOL singleMode;    //单张拍摄
    CustomAlertView *alertView;
    int morePhotoNumber;
    //请求登录对象
    ServiceHelper *helper;
}

@property (retain,nonatomic) IBOutlet UIButton *dataButton;
@property (retain,nonatomic) IBOutlet UIButton *shopButton;
@property (retain,nonatomic) IBOutlet UITextField *titleTextField;
@property (retain,nonatomic) IBOutlet UITextField *countTextField;
- (IBAction)showCalendar:(id)sender;



//跟拍摄有关的方法
- (IBAction)cancel:(id)sender;
- (IBAction)takePhoto:(id)sender;
- (IBAction)setFlashMode:(UIButton *)flashBtn;
- (IBAction)captureModeChanged:(id)sender;

@end
