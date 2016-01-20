//
//  ChannelTopModel.m
//  BProject
//
//  Created by lanouhn on 16/1/4.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "ChannelTopModel.h"

@implementation ChannelTopModel
+(id)channelTopModelWithDic:(NSDictionary *)dic {
    ChannelTopModel *model = [[ChannelTopModel alloc] init];
    model.podcast_num = dic[@"extra"][@"podcast_num"];
    model.photoNameArray = dic[@"data_list"];
    return model;
}
@end
