//
//  TwoCollectionViewCell.m
//  BProject
//
//  Created by lanouhn on 15/12/26.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "TwoCollectionViewCell.h"
#import "SecondModel.h"
@implementation TwoCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(SecondModel *)model {
    if (_model != model) {
        _model = model;
    }
    
    self.smallLabel.text = model.sub_title;
    self.titleLabel.text = model.title;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"jiazai"]];
}



@end
