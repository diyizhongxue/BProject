//
//  SubModel.m
//  BProject
//
//  Created by lanouhn on 16/1/4.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "SubModel.h"

@implementation SubModel
+(id)subModelWithDic:(NSDictionary *)dic {
    SubModel *model = [[SubModel alloc] init];
    model.ID = dic[@"id"];
    model.title = dic[@"title"];
    model.image_url = dic[@"image_url"];
    model.subscribe_num = dic[@"subscribe_num"];
    return model;
}
@end
