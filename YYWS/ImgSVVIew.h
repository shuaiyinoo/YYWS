//
//  ImgSVVIew.h
//  YYWS
//
//  Created by lvlei on 13-7-15.
//  Copyright (c) 2013年 三明泰格_帅 印. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ImgSVVIewDelegate <NSObject>

@optional
-(void)ImgSVVIewDidClicked:(NSUInteger)index;
@end

@interface ImgSVVIew : UIView<UIScrollViewDelegate> {
	CGRect viewSize;
	UIScrollView *scrollView;
	NSArray *imageArray;
    NSArray *titleArray;
    UIPageControl *pageControl;
    id<ImgSVVIewDelegate> delegate;
    int currentPageIndex;
    UILabel *noteTitle;
}
@property(nonatomic,retain)id<ImgSVVIewDelegate> delegate;
-(id)initWithFrameRect:(CGRect)rect ImageArray:(NSArray *)imgArr TitleArray:(NSArray *)titArr;
@end