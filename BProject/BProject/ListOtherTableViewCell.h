//
//  ListOtherTableViewCell.h
//  BProject
//
//  Created by lanouhn on 15/12/29.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListOtherModel;
@interface ListOtherTableViewCell : UITableViewCell
@property (nonatomic, strong)ListOtherModel *model;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *play_numLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end
