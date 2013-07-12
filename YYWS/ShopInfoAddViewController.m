//
//  ShopInfoAddViewController.m
//  YYWS
//
//  Created by 帅 印 on 13-7-11.
//  Copyright (c) 2013年 三明泰格_帅 印. All rights reserved.
//

#import "ShopInfoAddViewController.h"
#import "VRGViewController.h"
#import "UIButton+Badge.h"
#import "CustomAlertView.h"
#import "MBHUDView.h"

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define GET_IMAGE(__NAME__,__TYPE__)    [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:__NAME__ ofType:__TYPE__]]

@interface ShopInfoAddViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
    @property (nonatomic, retain) UIImagePickerController *imagePickerController;

    - (void)setupImagePicker:(UIImagePickerControllerSourceType)sourceType;
@end

@implementation ShopInfoAddViewController

@synthesize dataButton;
@synthesize imagePickerController;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    self.imagePickerController = nil;
    [imageArray release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    imageArray = [[NSMutableArray alloc] init];
    morePhotoNumber = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
}


//跟拍摄有关的方法
- (IBAction)cancel:(id)sender{
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
    [alertView release];
}
- (IBAction)takePhoto:(id)sender{
    singleMode = NO;
    morePhotoNumber = 0;//重新计数
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
     if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
     }
        
     UIImagePickerController *picker = [[UIImagePickerController alloc] init];
     picker.delegate = self;
        picker.allowsEditing = NO;
        self.imagePickerController = picker;
        [self setupImagePicker:sourceType];
        [picker release];
        picker = nil;
        
        UIToolbar *cameraOverlayView = (UIToolbar *)self.imagePickerController.cameraOverlayView;
        UIBarButtonItem *doneItem = [[cameraOverlayView items] lastObject];
        [doneItem setTitle:@"取消"];
        
        [self presentModalViewController:self.imagePickerController animated:YES];
}
- (IBAction)setFlashMode:(UIButton *)flashBtn{
    //ipad没有闪光灯，默认为 自动
    self.imagePickerController.cameraFlashMode = flashBtn.tag-100;
    //NSString *imageName = nil;
//    switch (flashBtn.tag) {
//        case 99:
//            imageName = @"jhztbg01";
//            break;
//        case 100:
//            imageName = @"jhztbg01";
//            break;
//        case 101:
//            imageName = @"jhztbg01";
//            break;
//        default:
//            break;
//    }
    //UIBarButtonItem *flashItem = [[(UIToolbar *)self.imagePickerController.cameraOverlayView items] objectAtIndex:0];
    //[(UIButton *)flashItem.customView setImage:GET_IMAGE(imageName, @"png") forState:UIControlStateNormal];
    
    [self cancel:nil];
}
- (IBAction)captureModeChanged:(id)sender{
    UISwitch *modeSwitch = (UISwitch *)sender;
    
    singleMode = ![modeSwitch isOn];
    
    UIToolbar *view = (UIToolbar *)self.imagePickerController.cameraOverlayView;
    UIBarButtonItem *cameraItem = [[view items] objectAtIndex:3];
    [(UIButton *)cameraItem.customView setBadge:singleMode? -1:0];
    
    [self cancel:nil];
}


//刷新图片
- (void)refreshImage
{
    //移除所有旧的子view
    for (UIView *subView in scrollView.subviews) {
        [subView removeFromSuperview];
    }
    
    scrollView.contentSize = CGSizeMake(280*imageArray.count, 250);
    for (int i = 0; i < imageArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[imageArray objectAtIndex:i]];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.frame = CGRectMake(i*280, 0, 280, 230);
        [scrollView addSubview:imageView];
        [imageView release];
    }
    
    //清空数组
    [imageArray removeAllObjects];
    [scrollView setContentOffset:CGPointZero];
}

//拍照
- (void)stillImage:(id)sender{
    if(morePhotoNumber == 3){
        [MBHUDView hudWithBody:@"最多三张" type:MBAlertViewHUDTypeCheckmark hidesAfter:2.0 show:YES];
    }else{
        //照片基数加一
        morePhotoNumber++;
        [self.imagePickerController takePicture];
        [MBHUDView hudWithBody:[NSString stringWithFormat:@"%d",morePhotoNumber] type:MBAlertViewHUDTypeDefault hidesAfter:0.5 show:YES];
    }

    //if(morePhotoNumber == 4){
    //   [self imagePickerControllerDidCancel:self.imagePickerController];
    //}
}

//完成、取消
- (void)doneAction
{
    [self imagePickerControllerDidCancel:self.imagePickerController];
}

#pragma mark - UIImagePickerController回调
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
    
    if (imageArray.count) {
        [self refreshImage];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //保存相片到数组，这种方法不可取,会占用过多内存
    //如果是一张就无所谓了，到时候自己改
    [imageArray addObject:[info objectForKey:UIImagePickerControllerOriginalImage]];
    if (singleMode) {
        [picker dismissModalViewControllerAnimated:YES];
        [self refreshImage];
    }
    else if (imageArray.count == 1) {
        //多张拍摄,不必每次都执行
        UIBarButtonItem *flashItem = [[(UIToolbar *)self.imagePickerController.cameraOverlayView items] lastObject];
        flashItem.title = @"完成";
    }
    
    UIToolbar *view = (UIToolbar *)self.imagePickerController.cameraOverlayView;
    UIBarButtonItem *cameraItem = [[view items] objectAtIndex:3];
    [(UIButton *)cameraItem.customView setBadge:imageArray.count];
}

//弹出选择
- (void)pushButton:(UIButton *)sender
{
    UIView *contentView = nil;
    if (sender.tag == 100) {
        //闪光灯
        contentView = flashView;
        //UIButton *button = (UIButton *)[flashView viewWithTag:self.imagePickerController.cameraFlashMode+100];
        //button.enabled = NO;
    }
    else {
        //模式
        contentView = modeView;
    }
    
    alertView = [[CustomAlertView alloc] initWithContentView:contentView
                                                       title:nil
                                                     message:nil
                                                    delegate:nil
                                           cancelButtonTitle:nil
                                           otherButtonTitles:nil];
    [alertView show];
}

- (void)changeCameraDevice:(id)sender
{
    if (self.imagePickerController.cameraDevice == UIImagePickerControllerCameraDeviceRear) {
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            self.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
    }
    else {
        self.imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }
}

//这里是主要函数
- (void)setupImagePicker:(UIImagePickerControllerSourceType)sourceType
{
    self.imagePickerController.sourceType = sourceType;
    
    if (sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        // 不使用系统的控制界面
        self.imagePickerController.showsCameraControls = NO;
        
        UIToolbar *controlView = [[UIToolbar alloc] initWithFrame:CGRectMake(0,self.view.frame.size.height+20, self.view.frame.size.width, 44)];
        controlView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        //闪光灯
        UIButton *flashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        flashBtn.frame = CGRectMake(0, 0, 50, 30);
        flashBtn.showsTouchWhenHighlighted = YES;
        flashBtn.tag = 100;
        [flashBtn setBackgroundImage:GET_IMAGE(@"jhztbg01.png", nil) forState:UIControlStateNormal];
        [flashBtn setTitle:@"闪光灯" forState:UIControlStateNormal];
        flashBtn.titleLabel.font = [UIFont systemFontOfSize: 12.0];
        [flashBtn addTarget:self action:@selector(pushButton:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *flashItem = [[UIBarButtonItem alloc] initWithCustomView:flashBtn];
        if (isPad) {
            //ipad,禁用闪光灯
            flashItem.enabled = NO;
        }
        
        //拍照
        UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cameraBtn.frame = CGRectMake(0, 0, 50, 30);
        cameraBtn.showsTouchWhenHighlighted = YES;
        //[cameraBtn setImage:GET_IMAGE(@"jhztbg03.png", nil) forState:UIControlStateNormal];
        [cameraBtn setBackgroundImage:GET_IMAGE(@"jhztbg03.png", nil) forState:UIControlStateNormal];
        [cameraBtn setTitle:@"拍照" forState:UIControlStateNormal];
        cameraBtn.titleLabel.font = [UIFont systemFontOfSize: 12.0];
        [cameraBtn addTarget:self action:@selector(stillImage:) forControlEvents:UIControlEventTouchUpInside];
        [cameraBtn badgeNumber:-1];
        UIBarButtonItem *takePicItem = [[UIBarButtonItem alloc] initWithCustomView:cameraBtn];
        
        //摄像头切换
        UIButton *cameraDevice = [UIButton buttonWithType:UIButtonTypeCustom];
        cameraDevice.frame = CGRectMake(0, 0, 50, 30);
        cameraDevice.showsTouchWhenHighlighted = YES;
        [cameraDevice setBackgroundImage:GET_IMAGE(@"jhztbg01.png", nil) forState:UIControlStateNormal];
        [cameraDevice setTitle:@"切换" forState:UIControlStateNormal];
        cameraDevice.titleLabel.font = [UIFont systemFontOfSize: 12.0];
        [cameraDevice addTarget:self action:@selector(changeCameraDevice:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *cameraDeviceItem = [[UIBarButtonItem alloc] initWithCustomView:cameraDevice];
        if (![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            //判断是否支持前置摄像头
            cameraDeviceItem.enabled = NO;
        }
        
        //取消、完成
        //UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered
        //target:self action:@selector(doneAction)];
        //取消，完成
        UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        doneBtn.frame = CGRectMake(0, 0, 50, 30);
        doneBtn.showsTouchWhenHighlighted = YES;
        doneBtn.tag = 101;
        [doneBtn setBackgroundImage:GET_IMAGE(@"jhztbg02.png", nil) forState:UIControlStateNormal];
        [doneBtn setTitle:@"取消" forState:UIControlStateNormal];
        doneBtn.titleLabel.font = [UIFont systemFontOfSize: 12.0];
        [doneBtn addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithCustomView:doneBtn];
        
        
        
        
        //模式：单张、多张
        //UIButton *modeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //modeBtn.frame = CGRectMake(0, 0, 50, 30);
        //modeBtn.showsTouchWhenHighlighted = YES;
        //modeBtn.tag = 101;
        //[modeBtn setBackgroundImage:GET_IMAGE(@"jhztbg01.png", nil) forState:UIControlStateNormal];
        //[modeBtn setTitle:@"模式" forState:UIControlStateNormal];
        //modeBtn.titleLabel.font = [UIFont systemFontOfSize: 12.0];
        //[modeBtn addTarget:self action:@selector(pushButton:) forControlEvents:UIControlEventTouchUpInside];
        //UIBarButtonItem *modeItem = [[UIBarButtonItem alloc] initWithCustomView:modeBtn];
        
        //空item
        UIBarButtonItem *spItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        NSArray *items = [NSArray arrayWithObjects:flashItem,cameraDeviceItem,takePicItem,spItem,spItem,doneItem, nil];
        [controlView setItems:items];
        
        [flashItem release];
        [takePicItem release];
        //[modeItem release];
        [cameraDeviceItem release];
        [doneItem release];
        [spItem release];
        
        self.imagePickerController.cameraOverlayView = controlView;
        
        [controlView release];
        controlView = nil;
    }
}
@end
