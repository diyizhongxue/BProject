//
//  TopScrollModel.h
//  BProject
//
//  Created by lanouhn on 16/1/1.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopScrollModel : NSObject
@property (nonatomic, copy) NSString *title, *image_url, *ID, *play_num;
+(id)scrollModelWithDic:(NSDictionary *)dic;
@end
