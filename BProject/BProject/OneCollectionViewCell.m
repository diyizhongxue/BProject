//
//  OneCollectionViewCell.m
//  BProject
//
//  Created by lanouhn on 15/12/26.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "OneCollectionViewCell.h"
#import "SecondModel.h"
@implementation OneCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    
}


- (void)setModel:(SecondModel *)model {
    if (_model != model) {
        _model = model;
    }
    self.smallLabel.text = model.sub_title;
    self.titleLabel.text = model.title;
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"jiazai"]];
}

@end
