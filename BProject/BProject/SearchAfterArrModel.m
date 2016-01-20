//
//  SearchAfterArrModel.m
//  BProject
//
//  Created by lanouhn on 15/12/27.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "SearchAfterArrModel.h"

@implementation SearchAfterArrModel

+(id)searchAfterArrModel:(NSDictionary *)dic{
    SearchAfterArrModel *afterModel = [[SearchAfterArrModel alloc] init];
        afterModel.ID = dic[@"id"];
        afterModel.title = dic[@"title"];
    return afterModel;
}

@end
