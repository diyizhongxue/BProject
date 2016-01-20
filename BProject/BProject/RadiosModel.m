//
//  RadiosModel.m
//  BProject
//
//  Created by lanouhn on 16/1/1.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "RadiosModel.h"

@implementation RadiosModel
+(id)newRadioModelWithDic:(NSDictionary *)dic{
    RadiosModel *model = [[RadiosModel alloc] init];
    model.ID = dic[@"id"];
    model.title = dic[@"title"];
    model.image_url = dic[@"image_url"];
    return model;
}

@end
