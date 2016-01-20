//
//  ThirdCollectionViewCell.h
//  BProject
//
//  Created by lanouhn on 15/12/26.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SecondModel;
@interface ThirdCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *smallLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) SecondModel *model;
@end
