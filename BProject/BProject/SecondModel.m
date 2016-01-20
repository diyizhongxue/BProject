//
//  SecondModel.m
//  BProject
//
//  Created by lanouhn on 15/12/25.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "SecondModel.h"

@implementation SecondModel

+(id)secondModelWithDic:(NSDictionary *)dic{
    SecondModel *second = [[SecondModel alloc] init];
    second.ID = dic[@"id"];
    second.title = dic[@"title"];
    second.image_url = dic[@"image_url"];
    second.item_value = dic[@"item_value"];
    second.sub_title = dic[@"sub_title"];
    return second;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, %@, %@, %@, %@",_ID, _title, _image_url, _item_value, _sub_title];
}

@end
