//
//  TodayThemeModel.h
//  BProject
//
//  Created by lanouhn on 16/1/4.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TodayThemeModel : NSObject
@property (nonatomic, copy) NSString *ID, *title, *desc, *image_url, *concern_num, *comment_num;
+(id)todayThemeModelWithDic:(NSDictionary *)dic;

@end
