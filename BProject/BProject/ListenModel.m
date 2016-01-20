//
//  ListenModel.m
//  BProject
//
//  Created by lanouhn on 16/1/5.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "ListenModel.h"

@implementation ListenModel
+(id)listenModelWithDic:(NSDictionary *)dic{
    ListenModel *model = [ListenModel new];
    model.ID = dic[@"id"];
    model.title = dic[@"title"];
    model.play_num = dic[@"play_num"];
    return model;
}
@end
