//
//  SubModel.h
//  BProject
//
//  Created by lanouhn on 16/1/4.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubModel : NSObject
@property (nonatomic, copy)NSString *ID, *title, *image_url, *subscribe_num;
+(id)subModelWithDic:(NSDictionary *)dic;
@end
