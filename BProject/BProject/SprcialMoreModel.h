//
//  SprcialMoreModel.h
//  BProject
//
//  Created by lanouhn on 15/12/30.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SprcialMoreModel : NSObject

@property (nonatomic, copy)NSString *item_value, *title, *image_url, *sub_title;
+(id)sprcialMoreModelwithDic:(NSDictionary *)dic;

@end
