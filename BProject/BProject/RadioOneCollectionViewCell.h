//
//  RadioOneCollectionViewCell.h
//  BProject
//
//  Created by lanouhn on 15/12/31.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDCycleScrollView;
@interface RadioOneCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) NSMutableArray *titlesGroup;
@property (nonatomic, assign) NSIndexPath *index;
@property (nonatomic, strong) NSMutableArray *scrollViewArray;

@end
