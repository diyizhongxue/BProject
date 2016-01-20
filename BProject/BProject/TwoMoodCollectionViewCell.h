//
//  TwoMoodCollectionViewCell.h
//  BProject
//
//  Created by lanouhn on 15/12/30.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ButtonSmallModel;
@interface TwoMoodCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *playNumLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (nonatomic , strong) ButtonSmallModel *model;

@end
