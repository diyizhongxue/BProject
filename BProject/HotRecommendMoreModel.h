//
//  HotRecommendMoreModel.h
//  BProject
//
//  Created by lanouhn on 15/12/30.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotRecommendMoreModel : NSObject
@property (nonatomic, copy) NSString *ID, *title, *image_url, *sub_title, *item_value;
+(id)hotRecommendMoreModelWithDic:(NSDictionary *)dic;
@end
