//
//  AlbumsCell.h
//  BProject
//
//  Created by lanouhn on 16/1/1.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RadiosModel;
@interface AlbumsCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, strong) RadiosModel *model;
@end
