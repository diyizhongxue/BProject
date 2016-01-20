//
//  SearchFrontArrModel.m
//  BProject
//
//  Created by lanouhn on 15/12/26.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "SearchFrontArrModel.h"

@implementation SearchFrontArrModel

+(id)searchFrontArrModelWithDic:(NSDictionary *)dic{
    SearchFrontArrModel *frontModel = [[SearchFrontArrModel alloc] init];
    frontModel.dataArray = [@[]mutableCopy];
    for (NSString *str in dic[@"data"]) {
        
        [frontModel.dataArray addObject:str];
    }
    return frontModel;
}

@end
