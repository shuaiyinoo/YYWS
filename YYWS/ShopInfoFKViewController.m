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
    
    [NSTimer scheduledTimerWithTimeInterval:1 target: self selector: @selector(handleTimer:)  userInfo:nil  repeats: YES];
    //判断显示几张图片
    
    
    Arr=[[NSArray alloc]initWithObjects:
         [self strtoImgStr:shopInfoEntity.img1],
         [self strtoImgStr:shopInfoEntity.img2],
         [self strtoImgStr:shopInfoEntity.img3],nil];
    [self AdImg:Arr];
    [self setCurrentPage:page.currentPage];
    
    page.hidden = YES;
    shopInfoEntityCount.editable = NO;
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



#pragma mark - 7秒换图片
- (void) handleTimer: (NSTimer *) timer
{
    if (TimeNum % 7 == 0 ){
        if (!Tend) {
            page.currentPage++;
            if (page.currentPage==page.numberOfPages-1) {
                Tend=YES;
            }
        }else{
            page.currentPage--;
            if (page.currentPage==0) {
                Tend=NO;
            }
        }
        
        [UIView animateWithDuration:0.7 //速度0.7秒
                         animations:^{//修改坐标
                             sv.contentOffset = CGPointMake(page.currentPage*320,0);
                         }];
        
    }
    TimeNum ++;
}
#pragma mark - 下载图片
void UIImageFromURL( NSURL * URL, void (^imageBlock)(UIImage * image), void (^errorBlock)(void) )
{
    dispatch_async( dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0 ), ^(void)
                   {
                       NSData * data = [[NSData alloc] initWithContentsOfURL:URL] ;
                       UIImage * image = [[UIImage alloc] initWithData:data];
                       dispatch_async( dispatch_get_main_queue(), ^(void){
                           if( image != nil )
                           {
                               imageBlock( image );
                           } else {
                               errorBlock();
                           }
                       });
                   });
}

-(void)AdImg:(NSArray*)arr{
    [sv setContentSize:CGSizeMake(320*[arr count], 250)];
    page.numberOfPages=[arr count];
    
    for ( int i=0; i<[arr count]; i++) {
        NSString *url=[arr objectAtIndex:i];
        UIButton *img=[[UIButton alloc]initWithFrame:CGRectMake(320*i, 0, 320, 250)];
        [img addTarget:self action:@selector(Action) forControlEvents:UIControlEventTouchUpInside];
        [sv addSubview:img];
        UIImageFromURL( [NSURL URLWithString:url], ^( UIImage * image )
                       {
                           [img setImage:image forState:UIControlStateNormal];
                       }, ^(void){
                       });
    }
    
}

-(void)Action{
    //NSURL *theurl = [NSURL URLWithString:[Arr objectAtIndex:page.currentPage]];
    //[wb loadRequest:[NSURLRequest requestWithURL:theurl]];
    NSLog(@"被点击了");
    
    
}

#pragma mark - scrollView && page
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    page.currentPage=scrollView.contentOffset.x/320;
    [self setCurrentPage:page.currentPage];
    
    
}
- (void) setCurrentPage:(NSInteger)secondPage {
    
    for (NSUInteger subviewIndex = 0; subviewIndex < [page.subviews count]; subviewIndex++) {
        UIImageView* subview = [page.subviews objectAtIndex:subviewIndex];
        CGSize size;
        size.height = 24/2;
        size.width = 24/2;
        [subview setFrame:CGRectMake(subview.frame.origin.x, subview.frame.origin.y,
                                     size.width,size.height)];
        if (subviewIndex == secondPage) [subview setImage:[UIImage imageNamed:@"b.png"]];
        else [subview setImage:[UIImage imageNamed:@"d.png"]];
    }
}


@end
