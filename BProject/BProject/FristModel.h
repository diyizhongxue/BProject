//
//  FristModel.h
//  BProject
//
//  Created by lanouhn on 15/12/25.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FristModel : NSObject
@property (nonatomic, copy) NSString *title, *ID, *redirect_value;
@property (nonatomic, strong) NSArray *dataArray;
+(id)fristModelWithDic:(NSDictionary *)dic;
@end
