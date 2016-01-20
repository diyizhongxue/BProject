//
//  MarkModel.h
//  BProject
//
//  Created by lanouhn on 16/1/1.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MarkModel : NSObject
@property (nonatomic, copy) NSString *ID, *title;
+(id)markModelWithDic:(NSDictionary *)dic;
@end
