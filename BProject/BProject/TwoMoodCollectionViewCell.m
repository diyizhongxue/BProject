//
//  TwoMoodCollectionViewCell.m
//  BProject
//
//  Created by lanouhn on 15/12/30.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "TwoMoodCollectionViewCell.h"
#import "ButtonSmallModel.h"
@implementation TwoMoodCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(ButtonSmallModel *)model {
    self.desLabel.text = model.title;
    self.playNumLabel.text = [NSString stringWithFormat:@"%d万", [model.play_num intValue] /10000];
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"pic@3x"]];
}

@end
