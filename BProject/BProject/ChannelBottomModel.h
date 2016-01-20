//
//  ChannelBottomModel.h
//  BProject
//
//  Created by lanouhn on 16/1/4.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelBottomModel : NSObject
@property (nonatomic, copy) NSString *ID, *title, *image_url;
+(id)channelBottomModelWithDic:(NSDictionary *)dic;
@end
