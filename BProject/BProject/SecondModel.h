//
//  SecondModel.h
//  BProject
//
//  Created by lanouhn on 15/12/25.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondModel : NSObject
@property (nonatomic, strong)NSString *ID, *title, *image_url, *item_value, *sub_title;
+(id)secondModelWithDic:(NSDictionary *)dic;
@end
