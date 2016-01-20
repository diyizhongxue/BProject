//
//  ListOtherModel.m
//  BProject
//
//  Created by lanouhn on 15/12/29.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "ListOtherModel.h"

@implementation ListOtherModel
+(id)listOtherModelWithDic:(NSDictionary *)dic{
    ListOtherModel *model = [[ListOtherModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
