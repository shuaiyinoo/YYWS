//
//  AppDelegate.m
//  YYWS
//
//  Created by 帅 印 on 13-7-3.
//  Copyright (c) 2013年 三明泰格_帅 印. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

#import "LoginViewController.h"

@implementation AppDelegate


- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        // 生成一个ViewControlle对象作为导航栏的第一个视图
        ViewController *viewController = [[[ViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil] autorelease];
        _naviController = [[UINavigationController alloc]initWithRootViewController:viewController];
        //给导航控制器设置颜色样式和按钮
        _naviController.navigationBar.tintColor = [UIColor blackColor];
        viewController.title = @"营运微视";
        //设置登录按钮
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"登录"style:UIBarButtonItemStyleDone target:self action:@selector(loginButton:)];
        viewController.navigationItem.rightBarButtonItem = rightButton;
        
        //将该导航栏作为根视图控制器；
        self.window.rootViewController = _naviController ;
        
    } else {
        self.viewController = [[[ViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil] autorelease];
        self.window.rootViewController = self.viewController;
    }
    [self.window makeKeyAndVisible];
    return YES;
}

//登录的按钮事件
-(void)loginButton:(id)sender{
    LoginViewController *loginc = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    loginc.title = @"用户登录";
    [self.naviController pushViewController:loginc animated:true];
    //[_naviController pushViewController:loginc animated:true];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
