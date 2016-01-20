//
//  ChannelTopModel.h
//  BProject
//
//  Created by lanouhn on 16/1/4.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelTopModel : NSObject
@property (nonatomic, copy)NSString *podcast_num;
@property (nonatomic, strong) NSMutableArray *photoNameArray;
+(id)channelTopModelWithDic:(NSDictionary *)dic;
@end
