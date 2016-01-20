//
//  MarkModel.m
//  BProject
//
//  Created by lanouhn on 16/1/1.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import "MarkModel.h"

@implementation MarkModel
+(id)markModelWithDic:(NSDictionary *)dic{
    MarkModel *model = [[MarkModel alloc] init];
    model.ID = dic[@"id"];
    model.title = dic[@"name"];
    return model;
}
@end
