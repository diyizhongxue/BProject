//
//  ListOtherTableViewCell.m
//  BProject
//
//  Created by lanouhn on 15/12/29.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "ListOtherTableViewCell.h"
#import "ListOtherModel.h"
@implementation ListOtherTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(ListOtherModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.titleLabel.text = model.title;
    self.play_numLabel.text = [NSString stringWithFormat:@"%.1f万", [model.play_num floatValue]/10000];
    //截取部分字符串
    self.timeLabel.text = [model.duration substringFromIndex:3];
    
}


@end
