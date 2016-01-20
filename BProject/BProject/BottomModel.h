//
//  BottomModel.h
//  BProject
//
//  Created by lanouhn on 15/12/31.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BottomModel : NSObject
@property (nonatomic, copy) NSNumber *total_page;
@property (nonatomic, copy) NSString *bigTitle;
//@property (nonatomic, strong) NSMutableArray *bottomArray;
+(id)bottomModelWithDic:(NSDictionary *)dic;

@end
