//
//  ShopInfoCell.h
//  YYWS
//
//  Created by 帅 印 on 13-7-4.
//  Copyright (c) 2013年 三明泰格_帅 印. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopInfoCell : UITableViewCell
@property (copy, nonatomic) UIImage *image;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *count;
@property (copy, nonatomic) NSString *info;

@property (strong, nonatomic) IBOutlet UIImageView *imageViews;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;
@property (strong, nonatomic) IBOutlet UILabel *infoLabel;

@end
