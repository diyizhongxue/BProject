//
//  HotAlbumsCell.m
//  BProject
//
//  Created by lanouhn on 16/1/1.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "HotAlbumsCell.h"
#import "HotRadioModel.h"
@implementation HotAlbumsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(HotRadioModel *)model {
    if (_model != model) {
        _model = model;
    }
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
    self.titleLabel.text = model.title;
    self.desLabel.text = model.desc;
    NSString *str2 = [[NSString alloc] init];
    for (NSString *str in model.tagsArr) {
       str2 = [str2 stringByAppendingFormat:@"%@ ", str];
    }
    self.markLabel.text = str2;
}

@end
