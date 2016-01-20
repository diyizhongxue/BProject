//
//  ChannelBottomModel.m
//  BProject
//
//  Created by lanouhn on 16/1/4.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "ChannelBottomModel.h"

@implementation ChannelBottomModel
+(id)channelBottomModelWithDic:(NSDictionary *)dic{
    ChannelBottomModel *model = [[ChannelBottomModel alloc] init];
    model.ID = dic[@"id"];
    model.title = dic[@"title"];
    model.image_url =  dic[@"image_url"];
    return model;
}

@end
