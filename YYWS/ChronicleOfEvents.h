//
//  ChronicleOfEvents.h
//  YYWS
//
//  Created by lvlei on 13-7-8.
//  Copyright (c) 2013年 三明泰格_帅 印. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ImgSVVIew.h"
#import "ServiceHelper.h"
#import "PullingRefreshTableView.h"

//引入文本自动滑动键盘滑动开源库
@class TPKeyboardAvoidingScrollView;

@interface ChronicleOfEvents : UIViewController<ImgSVVIewDelegate,UITableViewDataSource,UITableViewDelegate,ServiceHelperDelegate,PullingRefreshTableViewDelegate>{
}

@property (retain,nonatomic) PullingRefreshTableView *coeTableView;

@property (retain,nonatomic) IBOutlet UITextField *shopCodeBgTF;
@property (retain,nonatomic) IBOutlet UITextView *shopCodeTV;

@property (retain,nonatomic) IBOutlet UITextField *dataBgTF;
@property (retain,nonatomic) IBOutlet UITextView *dataTV;

@property (retain,nonatomic) IBOutlet UITextView *imgBgTV;

@property (retain,nonatomic) IBOutlet UITextView *contentBgTV;
@property (retain,nonatomic) IBOutlet UITextView *contentTV;

@property (retain,nonatomic) IBOutlet UIButton *uploadBtn;
@property (retain,nonatomic) IBOutlet UIButton *saveBtn;

@property (retain,nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

@property (retain,nonatomic) IBOutlet UIView *historyPage;

@property (retain,nonatomic) IBOutlet UIButton *editBtn;
@property (retain,nonatomic) IBOutlet UIButton *historyBtn;
@property (retain,nonatomic) IBOutlet UIButton *upAllBtn;


-(IBAction)saveButtonOnClick:(id)Sender;
-(IBAction)editButtonOnClick:(id)Sender;
-(IBAction)historyButtonOnClick:(id)Sender;
-(IBAction)upAllButtonOnClick:(id)Sender;
-(IBAction)searchButtonOnClick:(id)Sender;

@end
