//
//  ButtonSmallModel.m
//  BProject
//
//  Created by lanouhn on 15/12/31.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "ButtonSmallModel.h"

@implementation ButtonSmallModel

+(id)buttonSmallModelWithDic:(NSDictionary *)dic{
    ButtonSmallModel *smallModel = [[ButtonSmallModel alloc] init];
    smallModel.ID = dic[@"id"];
    smallModel.play_num = dic[@"play_num"];
    smallModel.title = dic[@"title"];
    smallModel.image_url = dic[@"image_url"];
    smallModel.desc = dic[@"describe"];
    return smallModel;
}

@end
