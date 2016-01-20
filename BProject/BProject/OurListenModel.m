
//
//  OurListenModel.m
//  BProject
//
//  Created by lanouhn on 16/1/5.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "OurListenModel.h"

@implementation OurListenModel
+(id)ourListenModelWithDic:(NSDictionary *)dic {
    OurListenModel *model = [OurListenModel new];
    model.ID =  dic[@"content"][@"id"];
    model.title = dic[@"content"][@"title"];
    model.bigImage = dic[@"album"][@"image_url"];
    model.realName = dic[@"user"][@"real_name"];
    model.smallImage = dic[@"user"][@"image_url"];
    model.des = dic[@"album"][@"title"];
    return model;
}
@end
