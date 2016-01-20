//
//  ListModel.m
//  BProject
//
//  Created by lanouhn on 15/12/29.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

+(id)listWithDic:(NSDictionary *)dic{
    ListModel *model = [[ListModel alloc] init];
    [model setValuesForKeysWithDictionary:dic];
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
