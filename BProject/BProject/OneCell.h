//
//  OneCell.h
//  BProject
//
//  Created by lanouhn on 16/1/4.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TodayThemeModel;
@interface OneCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UILabel *seeCount;
@property (nonatomic, strong) TodayThemeModel *model;
@end
