//
//  JKCustomAlert.m
//  AlertTest
//
//  Created by  on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "CSqlite.h"
#import <MapKit/MapKit.h>
#import "ServiceHelper.h"


@protocol JKCustomAlertDelegate <NSObject>
@optional
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

@interface JKCustomAlert : UIAlertView <UITextFieldDelegate,ServiceHelperDelegate,CLLocationManagerDelegate>{
    id  JKdelegate;
	UIImage *backgroundImage;
    NSMutableArray *_buttonArrays;
    UITextField *userName;
    UITextField *passWord;
    
    //请求登录对象
    ServiceHelper *helper;
    //获取GPS信息
    CLLocationManager *locationManager;
    //GPS修正过后的数据库
    CSqlite *m_sqlite;

}

@property(readwrite, retain) UIImage *backgroundImage;
@property(nonatomic, assign) id JKdelegate;
@property (nonatomic, retain) UITextField *userName;
@property (nonatomic, retain) UITextField *passWord;

- (id)initWithImage:(UIImage *)image;
-(void) addButtonWithUIButton:(UIButton *) btn;
-(void) addUserNameWithUITextField:(UITextField *) userName;
-(void) addPassWordWithUITextField:(UITextField *) passWord;
//定义方法异步请求WebServices
- (void)loginButtonAsycClick:(id)sender;
@end
