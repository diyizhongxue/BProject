//
//  ScorllTableViewCell.m
//  BProject
//
//  Created by lanouhn on 15/12/28.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "ScorllTableViewCell.h"
#import "ListModel.h"
#import <UIKit/UIKit.h>
@implementation ScorllTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setListModel:(ListModel *)model {
    if (_listModel != model) {
        _listModel = model;
    }
    //添加模糊背景
    UIBlurEffect *eff = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *v = [[UIVisualEffectView alloc] initWithEffect:eff];
    UIVisualEffectView *v1 = [[UIVisualEffectView alloc] initWithEffect:eff];
    v.frame = self.leftBackgroundView.bounds;
    v1.frame = self.rightbackgroundView.bounds;
    
    //左右侧背景图片
    [self.leftBackgroundView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
    [self.rightbackgroundView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
    [self.rightbackgroundView addSubview:v];
    [self.leftBackgroundView addSubview:v1];
    
    
    self.categoriesLabel.text = [NSString stringWithFormat:@"%@-%@",model.categories.firstObject ,model.categories.lastObject];
    self.content_numLabel.text = model.content_num;
    self.play_numLabel.text = [NSString stringWithFormat:@"%d万", [model.play_num intValue] / 10000];
    self.last_updated_timeLabel.text = model.last_updated_time;
    self.descriLabel.text = model.describe;
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
}

@end
