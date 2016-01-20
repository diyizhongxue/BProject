//
//  PlayerListModel.m
//  BProject
//
//  Created by lanouhn on 16/1/6.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "PlayerListModel.h"

@implementation PlayerListModel
+(id)playerListModelwithDic:(NSDictionary *)dic {
    PlayerListModel *model = [PlayerListModel new];
    model.ID = dic[@"id"];
    model.title = dic[@"title"];
    model.play_num = dic[@"play_num"];
    model.audio_32_url = dic[@"audio_32_url"];
    return model;
}
@end
