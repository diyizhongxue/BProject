//
//  OurListenModel.h
//  BProject
//
//  Created by lanouhn on 16/1/5.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OurListenModel : NSObject
@property (nonatomic, copy) NSString *ID, *title, *bigImage, *realName, *smallImage, *des;
+(id)ourListenModelWithDic:(NSDictionary *)dic;

@end
