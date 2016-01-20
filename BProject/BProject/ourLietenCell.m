//
//  ourLietenCell.m
//  BProject
//
//  Created by lanouhn on 16/1/5.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "ourLietenCell.h"

@implementation ourLietenCell

- (void)awakeFromNib {
    // Initialization code
    self.smallImage.layer.cornerRadius = KScreenHeight/5/ 4/ 2;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
