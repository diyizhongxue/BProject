//
//  ListModel.h
//  BProject
//
//  Created by lanouhn on 15/12/29.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListModel : NSObject

@property (nonatomic, copy) NSString *ID, *describe, *title, *image_url, *content_num, *play_num, *last_updated_time;
@property (nonatomic, copy) NSArray *categories;

+(id)listWithDic:(NSDictionary *)dic;
@end
