//
//  FristModel.m
//  BProject
//
//  Created by lanouhn on 15/12/25.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "FristModel.h"
#import "SecondModel.h"
@implementation FristModel

+(id)fristModelWithDic:(NSDictionary *)dic{
    FristModel *first = [[FristModel alloc] init];
    first.title = dic[@"column"][@"title"];
    first.ID = dic[@"column"][@"id"];
    first.redirect_value = dic[@"column"][@"redirect_value"];
    NSMutableArray *secondArray = [@[]mutableCopy];
    for (NSDictionary *dic1 in dic[@"data_list"]) {
        SecondModel *second = [SecondModel secondModelWithDic:dic1];
        [secondArray addObject:second];
    }
    first.dataArray = [NSArray arrayWithArray:secondArray];
    
    return first;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@, %@, %@", _title, _ID, _dataArray];
}

@end
