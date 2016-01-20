//
//  SprcialMoreModel.m
//  BProject
//
//  Created by lanouhn on 15/12/30.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "SprcialMoreModel.h"

@implementation SprcialMoreModel

+(id)sprcialMoreModelwithDic:(NSDictionary *)dic{
    SprcialMoreModel *model = [[SprcialMoreModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
//    if ([key isEqualToString:@"id"]) {
//        self.ID = value;
//    }
}

@end
