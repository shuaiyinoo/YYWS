//
//  ShopInfoViewController.m
//  YYWS
//
//  Created by 帅 印 on 13-7-4.
//  Copyright (c) 2013年 三明泰格_帅 印. All rights reserved.
//

#import "ShopInfoViewController.h"
#import "ShopInfoCell.h"
#import "SoapHelper.h"
#import "JSONKit.h"
#import "PullingRefreshTableView.h"
#import "ShopInfoEntity.h"
#import "ShopInfoFKViewController.h"
#import "VRGViewController.h"
#import "MBHUDView.h"

@interface ShopInfoViewController ()

@end

@implementation ShopInfoViewController


@synthesize shopInfoData;
@synthesize shopinfoTableView;
@synthesize refreshing = _refreshing;
@synthesize page = _page;
//合成条件
@synthesize shopcodeTextField;
@synthesize dataTextField;
@synthesize dataButton;

- (void)viewDidUnload
{
    [shopInfoData release];
    shopInfoData = nil;
    [shopinfoTableView release];
    
    [super viewDidUnload];
    
}

-(void) loadView{
    [super loadView];
    
    CGRect bounds = CGRectMake(0, 45, ScreenWidth, ScreenHeight-115);
    //bounds.size.height -= 40.f;
    self.shopinfoTableView = [[PullingRefreshTableView alloc] initWithFrame:bounds pullingDelegate:self];
    self.shopinfoTableView.dataSource = self;
    self.shopinfoTableView.delegate = self;
    self.shopinfoTableView.allowsSelection = YES;
    [self.view addSubview:shopinfoTableView];
    //时间长按事件
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(btnLong:)];
    longPress.minimumPressDuration = 0.8; //定义按的时间
    [dataButton addGestureRecognizer:longPress];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    //数据加载完成后初始化Helper对象
    helper=[[ServiceHelper alloc] initWithDelegate:self];
    //初始化table对象
    if (self.page == 0) {
        [self.shopinfoTableView launchRefreshing];
    }
    //禁止用户输入日期
    //[dataTextField resignFirstResponder];
    //dataTextField.userInteractionEnabled = NO;
    self.shopInfoData = [[NSMutableArray alloc]init];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.shopInfoData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ShopInfoCellIdentifier = @"ShopInfoCellIdentifier";
    
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"ShopInfoCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:ShopInfoCellIdentifier];
        nibsRegistered = YES;
    }
    
    ShopInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ShopInfoCellIdentifier];
    if (cell == nil) {
        cell = [[ShopInfoCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:ShopInfoCellIdentifier];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleBlue;
    
    NSUInteger row = [indexPath row];
    ShopInfoEntity *s = [self.shopInfoData objectAtIndex:row];
    cell.title = s.title;
    cell.count = s.count;
    cell.info = s.info;
    
    if([s.img1 isEqualToString:@""]&&[s.img2 isEqualToString:@""]&&[s.img3 isEqualToString:@""]){
        cell.image = [UIImage imageNamed:@"picicons.png"];
    }else{
        cell.image = [UIImage imageNamed:@"picicon.png"];
    }
    
    
    
    return cell;
}

//实现表示图的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   //在点击单元格的时候跳转到详细页面但是现在这里点击无效
        NSUInteger row = [indexPath row];
    
        ShopInfoFKViewController *shopFKInfo = [[ShopInfoFKViewController alloc]initWithNibName:@"ShopInfoFKViewController" bundle:nil];
        shopFKInfo.title = @"店铺详情";
        shopFKInfo.shopInfoEntity = [self.shopInfoData objectAtIndex:row];
    
        [self.navigationController pushViewController:shopFKInfo animated:true];
}
//- (NSIndexPath *)tableView:(UITableView *)tv willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSUInteger row = [indexPath row];
//    
//    ShopInfoFKViewController *shopFKInfo = [[ShopInfoFKViewController alloc]initWithNibName:@"ShopInfoFKViewController" bundle:nil];
//    shopFKInfo.title = @"店铺详情";
//    shopFKInfo.shopInfoEntity = [self.shopInfoData objectAtIndex:row];
//    
//    [self.navigationController pushViewController:shopFKInfo animated:true];
//    
//    return nil;
//}

//-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
//    NSUInteger row = [indexPath row];
//    
//    ShopInfoFKViewController *shopFKInfo = [[ShopInfoFKViewController alloc]initWithNibName:@"ShopInfoFKViewController" bundle:nil];
//    shopFKInfo.title = @"店铺详情";
//    shopFKInfo.shopInfoEntity = [self.shopInfoData objectAtIndex:row];
//    
//    [self.navigationController pushViewController:shopFKInfo animated:true];
//}


#pragma mark Table Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}


//当点击查询的时候加载数据
#pragma mark loadDate
-(IBAction)shopSerachButtonOnClick:(id)Sender{
    //从网络异步加载数据
    //[AppHelper showHUD:@"数据获取中"];//显示动画
    [MBHUDView hudWithBody:@"获取中" type:MBAlertViewHUDTypeCheckmark hidesAfter:3.0 show:YES];
    //归零页面
    self.page = 0;
    [self.shopInfoData removeAllObjects];
    
    [self loadData];
}

#pragma mark 异步请求结果
-(void)finishSuccessRequest:(NSString*)xml{
    //当查询出来的数据为空时说明没有数据
    
    if([xml isEqualToString:@"0"]){
        //如果为第一次的话就清空
        if(self.page-1 == 0){
            [self.shopInfoData removeAllObjects];
            [self.shopinfoTableView reloadData];
        }
        [self.shopinfoTableView tableViewDidFinishedLoadingWithMessage:@"全部加载已完成"];
        self.shopinfoTableView.reachedTheEnd  = YES;
    }else{
        //获取原来的数据
        //self.shopInfoData = [xml objectFromJSONString];
        NSMutableDictionary *infos = [xml objectFromJSONString];
        NSMutableArray *nsarray = [[NSMutableArray alloc]init];
        for (int i = 0; i<[infos count]; i++) {
            ShopInfoEntity *shopinfoentity = [[ShopInfoEntity alloc]init];
            shopinfoentity.title = [[infos valueForKey:@"title"] objectAtIndex:i];
            shopinfoentity.count = [[infos valueForKey:@"Content"] objectAtIndex:i];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *time = [[[infos valueForKey:@"uptime"] objectAtIndex:i] substringWithRange:NSMakeRange(6, 10)];
            NSDate *theday = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
            //1296873743 为date截取后的字符串 括号后开始的10位数字 从而转化为时间戳形式
            NSString *day = [dateFormatter stringFromDate:theday];
            NSArray *infoe = [NSArray arrayWithObjects:day,[[infos valueForKey:@"MDJC"] objectAtIndex:i],[[infos valueForKey:@"user_name"] objectAtIndex:i], nil];
                //使用完成后释放对象
            shopinfoentity.info = [infoe componentsJoinedByString:@" "];
            
            shopinfoentity.shopinfoID = [[infos valueForKey:@"id"] objectAtIndex:i];
            shopinfoentity.img1 = [[infos valueForKey:@"image1"] objectAtIndex:i];
            shopinfoentity.img2 = [[infos valueForKey:@"image2"] objectAtIndex:i];
            shopinfoentity.img3 = [[infos valueForKey:@"image3"] objectAtIndex:i];
            
            [nsarray addObject:shopinfoentity];
            [shopinfoentity release];
        }
        
        //if(self.page-1 == 0){
        //    self.shopInfoData = nsarray;
        //}else{
            [self.shopInfoData addObjectsFromArray:nsarray];
        //}
        
        [nsarray release];
        

        [self.shopinfoTableView tableViewDidFinishedLoading];
        self.shopinfoTableView.reachedTheEnd  = NO;
        [self.shopinfoTableView reloadData];
        
        if(self.page-1 != 0){
            //[AppHelper removeHUD];//移除动画
        }
    }
    

    
}
-(void)finishFailRequest:(NSError*)error{
    if(self.page-1 != 0){
        //[AppHelper removeHUD];//移除动画
    }
    [MBHUDView hudWithBody:@"获取失败" type:MBAlertViewHUDTypeExclamationMark hidesAfter:1.5 show:YES];
}




#pragma mark - PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    self.refreshing = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}

- (NSDate *)pullingTableViewRefreshingFinishedDate{
    NSDateFormatter *df = [[NSDateFormatter alloc] init ];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    NSDate *date = [df dateFromString:@"2013-07-03 10:10"];
    [df release];
    return date;
}

- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}

#pragma mark - Scroll

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.shopinfoTableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.shopinfoTableView tableViewDidEndDragging:scrollView];
}


#pragma mark - Your actions

- (void)loadData{
    
    if (self.refreshing) {
        self.page = 0;
        self.refreshing = NO;
        //开始请求服务器的数据
        //清空数据
        [self.shopInfoData removeAllObjects];
    }
    
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[shopcodeTextField text],@"mdbm", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"8880",@"usercode", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[dataTextField text],@"date", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pagecount", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%d",self.page+1],@"pageindex", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"type", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"GPSAddress", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"GPSJD", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"GPSWD", nil]];
    NSString *soapMsg=[SoapHelper arrayToDefaultSoapMessage:arr methodName:@"SearchShopSituation"];
    [helper asynServiceMethod:@"SearchShopSituation" soapMessage:soapMsg];
    
    //[arr release];
    
    self.page++;
}

//键盘放弃事件
-(IBAction)textFiledReturnEditing:(id)sender {
    [sender resignFirstResponder];
}


//显示日期选择控件
- (IBAction)showCalendar:(id)sender{
    VRGViewController *VRG = [[VRGViewController alloc] initWithNibName:@"VRGViewController" bundle:[NSBundle mainBundle]];
    VRG.delegate = self;
    //跳转界面
    [self presentModalViewController:VRG animated:YES];
}

//协议回调
//实现协议，在第一个窗口显示在第二个窗口输入的值，类似Android中的onActivityResult方法
-(void)passValue:(NSString *)value
{
    [dataButton setTitle:value forState:UIControlStateNormal];
    dataTextField.text = value;
}


-(void)btnLong:(UILongPressGestureRecognizer *)gestureRecognizer{
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        [dataButton setTitle:@"日期选择" forState:UIControlStateNormal];
        dataTextField.text = @"";
    }
}

@end
