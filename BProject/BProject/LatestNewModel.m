//
//  LatestNewModel.m
//  BProject
//
//  Created by lanouhn on 16/1/5.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "LatestNewModel.h"

@implementation LatestNewModel
+(id)latestNewModelWithDic:(NSDictionary *)dic {
    LatestNewModel *model = [LatestNewModel new];
    model.ID = dic[@"id"];
    model.title = dic[@"title"];
    model.image_url = dic[@"image_url"];
    model.created = dic[@"created"];
    return model;
}
@end
