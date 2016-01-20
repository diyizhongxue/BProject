//
//  TopScrollModel.m
//  BProject
//
//  Created by lanouhn on 16/1/1.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "TopScrollModel.h"

@implementation TopScrollModel

+(id)scrollModelWithDic:(NSDictionary *)dic {
    TopScrollModel *model = [[TopScrollModel alloc] init];
    model.title = dic[@"title"];
    model.image_url = dic[@"image_url"];
    model.ID = dic[@"album"][@"id"];
    model.play_num = dic[@"album"][@"play_num"];
    return model;
}
@end
