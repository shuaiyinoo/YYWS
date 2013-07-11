//
//  ShopInfoFKViewController.m
//  YYWS
//
//  Created by 帅 印 on 13-7-5.
//  Copyright (c) 2013年 三明泰格_帅 印. All rights reserved.
//

#import "ShopInfoFKViewController.h"
#import "ShopInfoEntity.h"

@interface ShopInfoFKViewController ()

@end

@implementation ShopInfoFKViewController

@synthesize shopInfoEntity;
@synthesize shopInfoEntityTitle;
@synthesize shopInfoEntityInfo;
@synthesize shopInfoEntityCount;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    shopInfoEntityTitle.text = shopInfoEntity.title;
    shopInfoEntityInfo.text = shopInfoEntity.info;
    shopInfoEntityCount.text = shopInfoEntity.count;
    shopInfoEntityCount.editable = NO;
    //判断分辨率的大小Iphone5为特别版本
    int height = 200;
    if(ScreenHeight == 568){
        height = 250;
    }
    EScrollerView *scroller=[[EScrollerView alloc] initWithFrameRect:CGRectMake(0, 60, ScreenWidth, height)
                                                          ImageArray:[NSArray arrayWithObjects:
                                                                      [self strtoImgStr:shopInfoEntity.img1],
                                                                      [self strtoImgStr:shopInfoEntity.img2],
                                                                      [self strtoImgStr:shopInfoEntity.img3], nil]
                                                          TitleArray:[NSArray arrayWithObjects:@"图一",@"图二",@"图三", nil]];
    scroller.delegate=self;
    [self.view addSubview:scroller];
    [scroller release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark 字符串截取
-(NSString *) strtoImgStr:(NSString *)oldImgSrc{
    if([oldImgSrc isEqualToString:@""]){
        return @"";
    }else{
        NSString *s = [oldImgSrc substringFromIndex:1];
        return [defaultWebServiceIMGURLSpace stringByAppendingString:s];
    }

}

-(void)EScrollerViewDidClicked:(NSUInteger)index
{
    NSLog(@"index--%d",index);
}

@end
