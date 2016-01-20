//
//  BottomModel.m
//  BProject
//
//  Created by lanouhn on 15/12/31.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "BottomModel.h"
//#import "ButtonSmallModel.h"
@implementation BottomModel
//BottomModel 里面的元素model.total_page, model.bigTitle , model.bottomArray, 数组

+(id)bottomModelWithDic:(NSDictionary *)dic {
    BottomModel *model = [[BottomModel alloc] init];
    model.total_page = dic[@"page"][@"total_page"];
    model.bigTitle = dic[@"category"][@"title"];
//    model.bottomArray = [@[]mutableCopy];
//    for (NSDictionary *dic1 in dic[@"data_list"]) {
//        ButtonSmallModel *smallMedol = [ButtonSmallModel buttonSmallModelWithDic:dic1];
//        [model.bottomArray addObject:smallMedol];
//    }
    return model;
}
@end
