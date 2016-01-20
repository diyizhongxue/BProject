//
//  SearchListTableViewCell.m
//  BProject
//
//  Created by lanouhn on 15/12/28.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "SearchListTableViewCell.h"
#import "SearchSpecialModel.h"
#import "SearchProgrameModel.h"
@implementation SearchListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(SearchSpecialModel *)model{
    if (_model != model) {
        _model = model;
    }
    self.titleLabel.text = model.title;
    self.playNumLabel.text = @"播放次数:";
    self.numLabel.text = [NSString stringWithFormat:@"%.1f万", [model.play_num floatValue]/10000];
    self.contentNumLabel.text = @"节目数量:";
    self.conNumLabel.text = [NSString stringWithFormat:@"%d", [model.content_num intValue]];
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
}

- (void)setModel2:(SearchProgrameModel *)model{
    if (_model2 != model) {
        _model2 = model;
    }
    self.titleLabel.text = model.title;
    self.playNumLabel.text = @"播放次数:";
    self.numLabel.text = [NSString stringWithFormat:@"%.1f万", [model.play_num floatValue]/10000];
    self.contentNumLabel.text = @"占用空间:";
    self.conNumLabel.text = [NSString stringWithFormat:@"%.1fM", [model.audio_64_size floatValue]/ (1024 * 1024)];
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
}



@end
