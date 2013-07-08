//
//  LoginViewController.h
//  yyws
//
//  Created by ll on 13-7-1.
//  Copyright (c) 2013年 三明泰格. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CSqlite.h"
#import <MapKit/MapKit.h>
#import "ServiceHelper.h"

//引入文本自动滑动键盘滑动开源库
@class TPKeyboardAvoidingScrollView;

@interface LoginViewController : UIViewController <UITextFieldDelegate,ServiceHelperDelegate,CLLocationManagerDelegate> {
    
    TPKeyboardAvoidingScrollView *scrollView;
    UITextField *txtUserCode;
    UITextField *txtPassWord;
    UIImageView *backbroundImage;
    
    //请求登录对象
    ServiceHelper *helper;
    //获取GPS信息
    CLLocationManager *locationManager;
    //GPS修正过后的数据库
    CSqlite *m_sqlite;
}
@property (nonatomic, retain) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UITextField *txtUserCode;
@property (nonatomic, retain) IBOutlet UITextField *txtPassWord;
@property (nonatomic, retain) IBOutlet UIImageView *backbroundImage;


//定义方法异步请求WebServices
- (IBAction)loginButtonAsycClick:(id)sender;

@end
