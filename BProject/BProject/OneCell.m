//
//  OneCell.m
//  BProject
//
//  Created by lanouhn on 16/1/4.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "OneCell.h"
#import "TodayThemeModel.h"
@implementation OneCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setModel:(TodayThemeModel *)model {
    if (_model != model) {
        _model = model;
    }
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:model.image_url]];
    self.titleLabel.text = model.title;
    self.seeCount.text = model.concern_num;
    self.commentCount.text = model.comment_num;
    self.desLabel.text = model.desc;
    //计算desLabel的高度
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
    
    
    CGRect rect = [model.desc boundingRectWithSize:CGSizeMake(KScreenWidth - 20, 0) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:dic context:nil];
    CGRect frame = self.desLabel.frame;
    frame.size.height = rect.size.height;
    self.desLabel.frame = frame;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
