//
//  ShopInfoCell.m
//  YYWS
//
//  Created by 帅 印 on 13-7-4.
//  Copyright (c) 2013年 三明泰格_帅 印. All rights reserved.
//

#import "ShopInfoCell.h"

@implementation ShopInfoCell

//属性合成
@synthesize image;
@synthesize title;
@synthesize count;
@synthesize info;

@synthesize imageViews;
@synthesize titleLabel;
@synthesize countLabel;
@synthesize infoLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}


//重写各个set函数
- (void)setImage:(UIImage *)img {
    if (![img isEqual:image]) {
        image = [img copy];
        self.imageViews.image = image;
    }
}

-(void)setTitle:(NSString *)t {
    if (![t isEqualToString:title]) {
        title = [t copy];
        self.titleLabel.text = title;
    }
}

-(void)setCount:(NSString *)c {
    if (![c isEqualToString:count]) {
        count = [c copy];
        self.countLabel.text = count;
    }
}

-(void)setInfo:(NSString *)i {
    if (![i isEqualToString:info]) {
        info = [i copy];
        self.infoLabel.text = info;
    }
}

@end
