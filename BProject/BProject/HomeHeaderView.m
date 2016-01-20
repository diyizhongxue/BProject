//
//  HomeHeaderView.m
//  BProject
//
//  Created by lanouhn on 15/12/25.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "HomeHeaderView.h"
#import "SDCycleScrollView.h"

@implementation HomeHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(0, 0, KScreenWidth, 230);
        self.imagesArray = [NSMutableArray arrayWithCapacity:0];

        self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenWidth, 200) imageURLStringsGroup:nil];
        //self.cycleScrollView.titlesGroup = @[@"1", @"2", @"3", @"4", @"5", @"6"];
        self.cycleScrollView.autoScrollTimeInterval = 2;
        [self addSubview:_cycleScrollView];
        //左侧标题
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.cycleScrollView.frame)+ 2, 80, 25)];
        [self addSubview:_titleLabel];
        //右侧按钮
        self.moreButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _moreButton.frame = CGRectMake(KScreenWidth - 60, CGRectGetMaxY(self.cycleScrollView.frame)+ 2, 40, 25);
        [_moreButton setImage:[UIImage imageNamed:@"more"] forState:(UIControlStateNormal)];
        [_moreButton addTarget:self action:@selector(click) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_moreButton];
    }
    return self;
}
//setter方法
- (void)setImagesArray:(NSMutableArray *)array {
    if (_imagesArray != array) {
        _imagesArray = array;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.cycleScrollView.imageURLStringsGroup = _imagesArray;
    });
}


- (void)click{
    
    if ([_delegate respondsToSelector:@selector(clickButton:)]) {
        [_delegate clickButton:self.index];
    }
}
@end
