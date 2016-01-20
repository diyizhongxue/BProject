//
//  TodayDetailModel.m
//  BProject
//
//  Created by lanouhn on 16/1/4.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "TodayDetailModel.h"

@implementation TodayDetailModel
+(id)todayDetailModelWithDic:(NSDictionary *)dic {
    TodayDetailModel *model  = [[TodayDetailModel alloc] init];
    model.ID = dic[@"id"];
    model.title = dic[@"title"];
    model.image_url = dic[@"image_url"];
    model.content_num = dic[@"content_num"];
    return model;
}
@end
