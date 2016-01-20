//
//  SearchListTableViewCell.h
//  BProject
//
//  Created by lanouhn on 15/12/28.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SearchSpecialModel;
@class SearchProgrameModel;
@interface SearchListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *playNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *conNumLabel;
@property (nonatomic, strong) SearchSpecialModel *model;

@property (nonatomic, strong)SearchProgrameModel *model2;
@end
