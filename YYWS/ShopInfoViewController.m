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

@interface ShopInfoViewController ()

@end

@implementation ShopInfoViewController
@synthesize shopInfoData;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //数据加载完成后初始化Helper对象
    helper=[[ServiceHelper alloc] initWithDelegate:self];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
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
    
    NSUInteger row = [indexPath row];
    
    cell.title = [[self.shopInfoData valueForKey:@"title"] objectAtIndex:row];
    cell.count = [[self.shopInfoData valueForKey:@"Content"] objectAtIndex:row];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *time = [[[self.shopInfoData valueForKey:@"uptime"] objectAtIndex:row] substringWithRange:NSMakeRange(6, 10)];
    NSDate *theday = [NSDate dateWithTimeIntervalSince1970:[time intValue]];
    //1296873743 为date截取后的字符串 括号后开始的10位数字 从而转化为时间戳形式
    NSString *day = [dateFormatter stringFromDate:theday];
    
    
    NSArray *infos = [NSArray arrayWithObjects:day,[[self.shopInfoData valueForKey:@"MDJC"] objectAtIndex:row],[[self.shopInfoData valueForKey:@"user_name"] objectAtIndex:row], nil];
    
    
    //使用完成后释放对象
    
    cell.info = [infos componentsJoinedByString:@" "];
    //cell.image = [imageList objectAtIndex:row];
    
    return cell;
}

#pragma mark Table Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


//当点击查询的时候加载数据
#pragma mark loadDate
-(IBAction)shopSerachButtonOnClick:(id)Sender{
    //从网络异步加载数据
    [AppHelper showHUD:@"数据获取中"];//显示动画
    //NSLog(@"=======异步请求开始======\n");
    NSMutableArray *arr=[NSMutableArray array];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"mdbm", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"8880",@"usercode", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"date", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"20",@"pagecount", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"pageindex", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"type", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"GPSAddress", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"GPSJD", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"0",@"GPSWD", nil]];
    NSString *soapMsg=[SoapHelper arrayToDefaultSoapMessage:arr methodName:@"SearchShopSituation"];
    [helper asynServiceMethod:@"SearchShopSituation" soapMessage:soapMsg];
}

#pragma mark 异步请求结果
-(void)finishSuccessRequest:(NSString*)xml{
    //获取数据完成后解析JSON数据
    self.shopInfoData = [xml objectFromJSONString];
    //NSArray *arr = [[resultsDictionary valueForKey:@"id"] objectAtIndex:0];
    
    //NSLog(@"所有的ID值:\n%@\n",[resultsDictionary valueForKey:@"id"]);
    
    
    //NSLog(@"异步请求返回的xml:\n%@\n",xml);
    
    [shopinfoTableView reloadData];
    
    [AppHelper removeHUD];//移除动画
}
-(void)finishFailRequest:(NSError*)error{
    //NSLog(@"异步请发生失败:%@\n",[error description]);
    [AppHelper removeHUD];//移除动画
}
@end
