//
//  ChangnelBottomCell.m
//  BProject
//
//  Created by lanouhn on 16/1/1.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "ChangnelBottomCell.h"
#import "ChannelBottomModel.h"
@implementation ChangnelBottomCell

- (void)awakeFromNib {
    // Initialization code
    self.photoView.layer.cornerRadius = (KScreenWidth - 50)/ 8;
}
-(void)setModel:(ChannelBottomModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.label.text = model.title;
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
}
@end
