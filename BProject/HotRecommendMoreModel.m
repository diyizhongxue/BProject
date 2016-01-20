//
//  HotRecommendMoreModel.m
//  BProject
//
//  Created by lanouhn on 15/12/30.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "HotRecommendMoreModel.h"

@implementation HotRecommendMoreModel

+(id)hotRecommendMoreModelWithDic:(NSDictionary *)dic {
    HotRecommendMoreModel *model = [[HotRecommendMoreModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
