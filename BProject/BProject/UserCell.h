//
//  UserCell.h
//  BProject
//
//  Created by lanouhn on 16/1/6.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@end
