//
//  PlayerListModel.h
//  BProject
//
//  Created by lanouhn on 16/1/6.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerListModel : NSObject
@property (nonatomic, copy) NSString *ID, *title, *play_num, *audio_32_url;
+(id)playerListModelwithDic:(NSDictionary *)dic;

@end
