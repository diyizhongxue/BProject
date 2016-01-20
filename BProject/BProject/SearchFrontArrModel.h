//
//  SearchFrontArrModel.h
//  BProject
//
//  Created by lanouhn on 15/12/26.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchFrontArrModel : NSObject
//@property (nonatomic, copy)NSString *string;
@property (nonatomic, strong)NSMutableArray *dataArray;
+(id)searchFrontArrModelWithDic:(NSDictionary *)dic;
@end
