//
//  ChronicleOfEvents.m
//  YYWS
//
//  Created by lvlei on 13-7-8.
//  Copyright (c) 2013年 三明泰格_帅 印. All rights reserved.
//

#import "ChronicleOfEvents.h"
#import <QuartzCore/QuartzCore.h>

@interface ChronicleOfEvents ()

@end

@implementation ChronicleOfEvents

@synthesize dataTV;
@synthesize shopCodeTV;
@synthesize contentTV;
@synthesize saveBtn;
@synthesize uploadBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [_shopCodeBgTF setEnabled:NO];
    [_dataBgTF setEnabled:NO];
    
    _imgBgTV.layer.borderWidth = 1.0;
    _imgBgTV.layer.cornerRadius = 9.0;
    [_imgBgTV setEditable:NO];
    
    _contentBgTV.layer.borderWidth = 1.0;
    _contentBgTV.layer.cornerRadius = 9.0;
    [_contentBgTV setEditable:NO];
    
    [uploadBtn setImage:[UIImage imageNamed:@"g_upload_btn1.png"] forState:UIControlStateHighlighted];
    [saveBtn setImage:[UIImage imageNamed:@"g_save_btn1.png"] forState:UIControlStateHighlighted];
    
    ImgSVVIew *scroller=[[ImgSVVIew alloc] initWithFrameRect:CGRectMake(63, 85, 235, 107)
                                                          ImageArray:[NSArray arrayWithObjects:@"p01.png",@"p01.png",@"p01.png", nil]
                                                          TitleArray:[NSArray arrayWithObjects:@"",@"",@"", nil]];
    scroller.delegate=self;
    [_scrollView addSubview:scroller];
    [scroller release];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)editButtonOnClick:(id)Sender{
    switch ([_editBtn tag]) {
        case 0:
            break;
        case 1:
            [_editBtn setBackgroundImage:[UIImage imageNamed:@"g_tab01.png"] forState:UIControlStateNormal];
            [_editBtn setTag:0];
            [_historyBtn setBackgroundImage:[UIImage imageNamed:@"g_tab03s.png"] forState:UIControlStateNormal];
            [_historyBtn setTag:1];
            [_upAllBtn setBackgroundImage:[UIImage imageNamed:@"g_tab02s.png"] forState:UIControlStateNormal];
            [_upAllBtn setTag:1];
            [_historyPage setHidden:true];
            [_scrollView setHidden:FALSE];
//            [_upallPage setHidden:true];
            break;
    }
}

-(IBAction)historyButtonOnClick:(id)Sender{
    switch ([_historyBtn tag]) {
        case 0:
            break;
        case 1:
            [_editBtn setBackgroundImage:[UIImage imageNamed:@"g_tab01s.png"] forState:UIControlStateNormal];
            [_editBtn setTag:1];
            [_upAllBtn setBackgroundImage:[UIImage imageNamed:@"g_tab02s.png"] forState:UIControlStateNormal];
            [_upAllBtn setTag:1];
            [_historyBtn setBackgroundImage:[UIImage imageNamed:@"g_tab03.png"] forState:UIControlStateNormal];
            [_historyBtn setTag:0];
            [_historyPage setHidden:FALSE];
            [_scrollView setHidden:true];
//            [_upallPage setHidden:true];
            break;
    }
}

-(IBAction)upAllButtonOnClick:(id)Sender{
    switch ([_upAllBtn tag]) {
        case 0:
            break;
        case 1:
            [_upAllBtn setBackgroundImage:[UIImage imageNamed:@"g_tab02.png"] forState:UIControlStateNormal];
            [_upAllBtn setTag:0];
            [_editBtn setBackgroundImage:[UIImage imageNamed:@"g_tab01s.png"] forState:UIControlStateNormal];
            [_editBtn setTag:1];
            [_historyBtn setBackgroundImage:[UIImage imageNamed:@"g_tab03s.png"] forState:UIControlStateNormal];
            [_historyBtn setTag:1];
            [_historyPage setHidden:TRUE];
            [_scrollView setHidden:TRUE];
//            [_upallPage setHidden:FALSE];
            break;
    }
}

-(IBAction)searchButtonOnClick:(id)Sender{
    
    CGRect bounds = CGRectMake(0, 45, ScreenWidth, ScreenHeight-115);
    bounds.size.height -= 40.f;
    self.coeTableView = [[PullingRefreshTableView alloc] initWithFrame:bounds pullingDelegate:self];
    self.coeTableView.dataSource = self;
    self.coeTableView.delegate = self;
    self.coeTableView.allowsSelection = YES;
    [_historyPage addSubview:_coeTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
