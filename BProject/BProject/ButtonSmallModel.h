//
//  ButtonSmallModel.h
//  BProject
//
//  Created by lanouhn on 15/12/31.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ButtonSmallModel : NSObject
@property (nonatomic, copy) NSString *ID, *play_num, *title, *image_url, *desc;
+(id)buttonSmallModelWithDic:(NSDictionary *)dic;

@end
