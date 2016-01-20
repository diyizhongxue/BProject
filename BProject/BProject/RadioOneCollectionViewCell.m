//
//  RadioOneCollectionViewCell.m
//  BProject
//
//  Created by lanouhn on 15/12/31.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "RadioOneCollectionViewCell.h"
#import "SDCycleScrollView.h"
#import "TopScrollModel.h"
@implementation RadioOneCollectionViewCell

- (void)awakeFromNib {
    
    self.imagesArray = [NSMutableArray arrayWithCapacity:0];
    self.titlesGroup = [@[] mutableCopy];
    self.scrollViewArray = [@[] mutableCopy];
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight / 6) imageURLStringsGroup:nil];
    self.cycleScrollView.autoScrollTimeInterval = 2;
    [self addSubview:_cycleScrollView];
}

-(void)setScrollViewArray:(NSMutableArray *)scrollViewArray {
    if (_scrollViewArray != scrollViewArray) {
        _scrollViewArray = scrollViewArray;
    }
    for (TopScrollModel *model in _scrollViewArray) {
        [self.imagesArray addObject:model.image_url];
        [self.titlesGroup addObject:model.title];
    }
    
    self.cycleScrollView.titlesGroup = self.titlesGroup;
    self.cycleScrollView.imageURLStringsGroup = self.imagesArray;
}


@end
