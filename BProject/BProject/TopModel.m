//
//  TopModel.m
//  BProject
//
//  Created by lanouhn on 15/12/31.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "TopModel.h"

@implementation TopModel
+(id)topModelWithDic:(NSDictionary *)dic{
    TopModel *model = [[TopModel alloc] init];
    model.ID = dic[@"id"];
    model.title = dic[@"title"];
    return model;
}

@end
