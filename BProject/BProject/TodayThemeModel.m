//
//  TodayThemeModel.m
//  BProject
//
//  Created by lanouhn on 16/1/4.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "TodayThemeModel.h"

@implementation TodayThemeModel
+(id)todayThemeModelWithDic:(NSDictionary *)dic {
    TodayThemeModel *model = [[TodayThemeModel alloc] init];
    model.ID = dic[@"topic"][@"id"];
    model.title = dic[@"topic"][@"title"];
    model.desc = dic[@"topic"][@"describe"];
    model.image_url = dic[@"topic"][@"image_url"];
    model.concern_num = dic[@"topic"][@"concern_num"];
    model.comment_num = dic[@"topic"][@"comment_num"];
    return model;
}
@end
