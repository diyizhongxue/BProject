//
//  TodayDetailModel.h
//  BProject
//
//  Created by lanouhn on 16/1/4.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodayDetailModel : NSObject
@property (nonatomic, copy) NSString *ID, *title, *image_url, *content_num;
+(id)todayDetailModelWithDic:(NSDictionary *)dic;

@end
