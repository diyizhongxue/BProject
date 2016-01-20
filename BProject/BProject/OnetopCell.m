//
//  OnetopCell.m
//  BProject
//
//  Created by lanouhn on 16/1/4.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "OnetopCell.h"

@implementation OnetopCell

- (void)awakeFromNib {
    // Initialization code
    self.image2.layer.cornerRadius = 0.15*KScreenWidth/2;
    self.image3.layer.cornerRadius = 0.15*KScreenWidth/2;
    self.image4.layer.cornerRadius = 0.15*KScreenWidth/2;
}

@end
