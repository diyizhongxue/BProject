//
//  HotRadioModel.m
//  BProject
//
//  Created by lanouhn on 15/12/31.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "HotRadioModel.h"

@implementation HotRadioModel
+(id)hotRadioModelWithDic:(NSDictionary *)dic {
    HotRadioModel *model = [[HotRadioModel alloc] init];
    model.ID = dic[@"id"];
    model.title = dic[@"title"];
    model.desc = dic[@"describe"];
    model.image_url = dic[@"image_url"];
    model.play_num = dic[@"play_num"];
    model.tagsArr = [@[] mutableCopy];
    for (NSDictionary *dic1 in dic[@"tags"]) {
        [model.tagsArr addObject:dic1[@"name"]];
    }
    
    return model;
}
@end
