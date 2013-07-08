//
//  LoginViewController.m
//  yyws
//
//  Created by ll on 13-7-4.
//  Copyright (c) 2013年 三明泰格. All rights reserved.
//

#import "LoginViewController.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "SoapHelper.h"
#import "ASIHTTPRequest.h"
#import "SoapXmlParseHelper.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

//属性合成
@synthesize scrollView;
@synthesize txtUserCode;
@synthesize txtPassWord;
@synthesize backbroundImage;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //设置的背景
        //判断屏幕分辨率
        if(ScreenHeight == 480){
            backbroundImage.image = [UIImage imageNamed:@"Default.png"];
        }else if(ScreenHeight == 960){
            backbroundImage.image = [UIImage imageNamed:@"Default@2x.png"];
        }else if(ScreenHeight == 1136){
            backbroundImage.image = [UIImage imageNamed:@"Default-568h@2x.png"];
        }
        
        //当该视图启动是获取GPS信息
        if ([CLLocationManager locationServicesEnabled]) { // 检查定位服务是否可用
            locationManager = [[CLLocationManager alloc] init];
            locationManager.delegate = self;
            locationManager.distanceFilter=0.5;
            locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            [locationManager startUpdatingLocation]; // 开始定位
        }
        
        //初始化数据库
        m_sqlite = [[CSqlite alloc]init];
        [m_sqlite openSqlite];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //数据加载完成后初始化Helper对象
    helper=[[ServiceHelper alloc] initWithDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


//这个必须放到  @implementation LoginViewController  后面
//下面这两个方法是加入键盘的滑动事件
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [scrollView adjustOffsetToIdealIfNeeded];
}

//下面这个方法是控制键盘的返回类型
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == txtUserCode) {
        [txtUserCode becomeFirstResponder];
    }else if (textField == txtPassWord) {
        [txtPassWord becomeFirstResponder];
    }else{
        [textField resignFirstResponder];
    }
    return YES;
}

//异步登录请求WebServices
- (IBAction)loginButtonAsycClick:(id)sender{
    
    //判断非空
    if ([txtUserCode text].length == 0 || [txtPassWord text].length == 0) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入完整用户编码、密码。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alter show];
        [alter release];
        return;
    }
    
    [AppHelper showHUD:@"loading"];//显示动画
    //NSLog(@"=======异步请求开始======\n");
    NSMutableArray *arr=[NSMutableArray array];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"mdbm", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[txtUserCode text],@"usercode", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:[txtPassWord text],@"pwd", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:![defaults objectForKey:@"address"]?@"":[defaults objectForKey:@"address"],@"GPSAddress", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:![defaults objectForKey:@"lat"]?@"":[defaults objectForKey:@"lat"],@"GPSJD", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:![defaults objectForKey:@"lon"]?@"":[defaults objectForKey:@"lon"],@"GPSWD", nil]];
    [arr addObject:[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"type", nil]];
    NSString *soapMsg=[SoapHelper arrayToDefaultSoapMessage:arr methodName:@"SheCha_LoginUser"];
    [helper asynServiceMethod:@"SheCha_LoginUser" soapMessage:soapMsg];
}
#pragma mark 异步请求结果
-(void)finishSuccessRequest:(NSString*)xml{
    
    //将xml使用SoapXmlParseHelper类转换成想要的结果
    
    NSArray *xmlItem = [xml componentsSeparatedByString:@"|||"];
        
    if([[xmlItem objectAtIndex:(0)] isEqualToString:@"0"]){
        
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:[xmlItem objectAtIndex:(1)] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alter show];
        [alter release];
        
    }else if([[xmlItem objectAtIndex:(0)] isEqualToString:@"1"]){
        
        NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
        [defaults setObject:[xmlItem objectAtIndex:(2)] forKey:@"userType"];
        [defaults setObject:[xmlItem objectAtIndex:(3)] forKey:@"shopInfo"];
        [defaults setObject:[xmlItem objectAtIndex:(4)] forKey:@"shelfType"];
        [defaults setObject:[xmlItem objectAtIndex:(5)] forKey:@"qy"];
        [defaults synchronize];//用synchronize方法把数据持久化到standardUserDefaults数据库
        
    }
    [AppHelper removeHUD];//移除动画
}
-(void)finishFailRequest:(NSError*)error{
//    NSLog(@"异步请发生失败:%@\n",[error description]);
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"登陆失败、请检查网络。" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alter show];
    [alter release];
    [AppHelper removeHUD];//移除动画
}
- (void)dealloc {
    [helper release];
    [super dealloc];
}

// 定位失败时调用
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
}
// 定位成功时调用
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    CLLocationCoordinate2D mylocation = newLocation.coordinate;//手机GPS
    
    //修正GPS
    mylocation = [self zzTransGPS:mylocation];
    
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSString stringWithFormat:@"%lf",mylocation.latitude] forKey:@"lat"];
    [defaults setObject:[NSString stringWithFormat:@"%lf",mylocation.longitude] forKey:@"lon"];
    
    //获取位置信息
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray* placemarks,NSError *error){
        if (placemarks.count >0   ){
            CLPlacemark * plmark = [placemarks objectAtIndex:0];
            NSString * country = plmark.country;
            NSString * city    = plmark.locality;
            
            [defaults setObject:@"地址" forKey:@"address"];
            
//            NSLog(@"%@-%@-%@",country,city,plmark.name);
//            self.m_locationName.text =plmark.name;
        }
    }];
    [defaults synchronize];//用synchronize方法把数据持久化到standardUserDefaults数据库
}

-(CLLocationCoordinate2D)zzTransGPS:(CLLocationCoordinate2D)yGps
{
    int TenLat=0;
    int TenLog=0;
    TenLat = (int)(yGps.latitude*10);
    TenLog = (int)(yGps.longitude*10);
    NSString *sql = [[NSString alloc]initWithFormat:@"select offLat,offLog from gpsT where lat=%d and log = %d",TenLat,TenLog];
    sqlite3_stmt* stmtL = [m_sqlite NSRunSql:sql];
    int offLat=0;
    int offLog=0;
    while (sqlite3_step(stmtL)==SQLITE_ROW)
    {
        offLat = sqlite3_column_int(stmtL, 0);
        offLog = sqlite3_column_int(stmtL, 1);
    }
    
    yGps.latitude = yGps.latitude+offLat*0.0001;
    yGps.longitude = yGps.longitude + offLog*0.0001;
    return yGps;
}
@end
