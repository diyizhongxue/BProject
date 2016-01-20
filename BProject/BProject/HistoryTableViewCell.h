//
//  HistoryTableViewCell.h
//  BProject
//
//  Created by lanouhn on 16/1/13.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@end
