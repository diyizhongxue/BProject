//
//  HotAlbumsCell.h
//  BProject
//
//  Created by lanouhn on 16/1/1.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HotRadioModel;
@interface HotAlbumsCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *markLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (nonatomic, strong) HotRadioModel *model;
@end
