//
//  UserCell.m
//  BProject
//
//  Created by lanouhn on 16/1/6.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "UserCell.h"

@implementation UserCell

- (void)awakeFromNib {
    // Initialization code
    
    self.photoView.layer.cornerRadius = KScreenHeight/6 *2/3/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
