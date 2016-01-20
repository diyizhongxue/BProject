//
//  AlbumsCell.m
//  BProject
//
//  Created by lanouhn on 16/1/1.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "AlbumsCell.h"
#import "RadiosModel.h"
@implementation AlbumsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(RadiosModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.label.text = _model.title;
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
}
@end
