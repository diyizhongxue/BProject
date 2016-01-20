//
//  WelcomePageView.m
//  Yike
//
//  Created by lanouhn on 15/12/7.
//  Copyright (c) 2015年 lanou. All rights reserved.
//
#define kKEY_WINDOW [[UIApplication sharedApplication] keyWindow]
#import "WelcomePageView.h"

@interface WelcomePageView()
@property (nonatomic, retain) UIScrollView * grideScroll;
@end

@implementation WelcomePageView

- (id)initWithFrame:(CGRect)frame
         namesArray:(NSArray *)items
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.frame = [[UIScreen mainScreen] bounds];
        [kKEY_WINDOW addSubview:self];
        
        self.grideScroll = [[UIScrollView alloc] initWithFrame:self.bounds];
        self.grideScroll.contentSize = CGSizeMake(kKEY_WINDOW.frame.size.width * items.count, kKEY_WINDOW.frame.size.height);
        self.grideScroll.pagingEnabled = YES;
        [self addSubview:self.grideScroll];
        
        [self loadImagesWithArray:items];
    }
    return self;
}



- (void)loadImagesWithArray:(NSArray *)items
{
    for (int i = 0; i < items.count; i++)
    {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * kKEY_WINDOW.frame.size.width, 0, kKEY_WINDOW.frame.size.width, kKEY_WINDOW.frame.size.height)];
        imageView.userInteractionEnabled = YES;
        imageView.image = [UIImage imageNamed:[items objectAtIndex:i]];
        [self.grideScroll addSubview:imageView];
        
        if (i == items.count - 1) {
            self.guideBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _guideBtn.frame = CGRectMake(120,
                                         kKEY_WINDOW.frame.size.height - 160,
                                         kKEY_WINDOW.frame.size.width - 220,
                                         100);
            _guideBtn.layer.cornerRadius = 20;
            [_guideBtn setImage:[UIImage imageNamed:@"GO1"] forState:UIControlStateNormal];
            [imageView addSubview:_guideBtn];
        }
    }
}

- (void)dealloc
{
    self.guideBtn = nil;

}

@end
