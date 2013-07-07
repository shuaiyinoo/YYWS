//
//  ShopInfoEntity.h
//  YYWS
//
//  Created by 帅 印 on 13-7-5.
//  Copyright (c) 2013年 三明泰格_帅 印. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopInfoEntity : NSObject
{
    NSString *title;
    NSString *count;
    NSString *info;
    NSString *shopinfoID;
    NSString *img1;
    NSString *img2;
    NSString *img3;
}

@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) NSString *count;
@property(nonatomic,retain) NSString *info;
@property(nonatomic,retain) NSString *shopinfoID;
@property(nonatomic,retain) NSString *img1;
@property(nonatomic,retain) NSString *img2;
@property(nonatomic,retain) NSString *img3;

@end
