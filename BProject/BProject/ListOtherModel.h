//
//  ListOtherModel.h
//  BProject
//
//  Created by lanouhn on 15/12/29.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListOtherModel : NSObject
@property (nonatomic , copy) NSString *title, *duration, *play_num, *audio_32_url, *ID;
+(id)listOtherModelWithDic:(NSDictionary *)dic;

@end
