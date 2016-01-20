//
//  ScorllTableViewCell.h
//  BProject
//
//  Created by lanouhn on 15/12/28.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListModel;

@interface ScorllTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *categoriesLabel;
@property (weak, nonatomic) IBOutlet UILabel *content_numLabel;
@property (weak, nonatomic) IBOutlet UILabel *play_numLabel;
@property (weak, nonatomic) IBOutlet UILabel *last_updated_timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriLabel;
@property (nonatomic, strong) ListModel *listModel;
@property (weak, nonatomic) IBOutlet UIImageView *leftBackgroundView;
@property (weak, nonatomic) IBOutlet UIImageView *rightbackgroundView;


@end
