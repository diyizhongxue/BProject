//
//  LatestNewModel.h
//  BProject
//
//  Created by lanouhn on 16/1/5.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LatestNewModel : NSObject
@property (nonatomic,copy) NSString *ID, *title, *image_url, *created;
+(id)latestNewModelWithDic:(NSDictionary *)dic;

@end
