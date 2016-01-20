//
//  TopModel.h
//  BProject
//
//  Created by lanouhn on 15/12/31.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopModel : NSObject
@property (nonatomic, copy) NSString *ID, *title;
+(id)topModelWithDic:(NSDictionary *)dic;
@end
