//
//  HomeHeaderView.h
//  BProject
//
//  Created by lanouhn on 15/12/25.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDCycleScrollView;
//指定代理
@protocol HomeHeaderViewDelegate <NSObject>

@optional//不必要实现的方法
- (void)clickButton:(NSIndexPath *)index;//点击

@end

@interface HomeHeaderView : UICollectionReusableView
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, assign) NSIndexPath *index;
@property (nonatomic, assign) id <HomeHeaderViewDelegate> delegate;

@end
