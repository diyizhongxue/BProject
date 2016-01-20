//
//  OneCollectionViewCell.h
//  BProject
//
//  Created by lanouhn on 15/12/26.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SecondModel;
@interface OneCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *smallLabel;
@property (nonatomic, strong) SecondModel *model;

@end
