//
//  PlayerModel.m
//  BProject
//
//  Created by lanouhn on 15/12/29.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "PlayerModel.h"

@implementation PlayerModel
+(id)playerModelWithDic:(NSDictionary *)dic{
    PlayerModel *playerModel = [[PlayerModel alloc] init];
    playerModel.title =  dic[@"content"][@"title"];
    playerModel.audio_32_url = dic[@"content"][@"audio_32_url"];
    playerModel.describe = dic[@"content"][@"describe"];
    playerModel.described = dic[@"content"][@"described"];
    playerModel.bigImage_url = dic[@"album"][@"image_url"];
    playerModel.topTitle = dic[@"album"][@"title"];
    playerModel.ID = dic[@"content"][@"id"];
    if (![dic[@"podcast"] isKindOfClass:[NSNull class] ]) {
        playerModel.real_name = dic[@"podcast"][@"real_name"];
        playerModel.smallImage = dic[@"podcast"][@"image_url"];
    }
    if (![dic[@"latest_comments"][@"data_list"] isKindOfClass:[NSNull class]] ) {
        playerModel.playerArr = dic[@"latest_comments"][@"data_list"];
    }
    return playerModel;
}

@end
