//
//  WKSlide.h
//  WuKongCommerce
//
//  Created by 小悟空 on 14-9-10.
//  Copyright (c) 2014年 小悟空. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GKCarouselViewDelegate.h"

@interface GKCarouselView : UIView
<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) CGFloat marginBottom;
@property (nonatomic, strong) NSArray *slides;
@property (nonatomic, strong) id<GKCarouselViewDelegate> delegate;

- (void)setPageControlColor:(UIColor *)color;
- (void)reloadData;
@end
