//
//  PlayerModel.h
//  BProject
//
//  Created by lanouhn on 15/12/29.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerModel : NSObject
@property (nonatomic, copy) NSString *title, *audio_32_url, *describe, *real_name, *bigImage_url,*topTitle, *smallImage, *described, *ID;
@property (nonatomic, strong) NSArray *playerArr;
+(id)playerModelWithDic:(NSDictionary *)dic;

@end
