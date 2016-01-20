//
//  RadiosModel.h
//  BProject
//
//  Created by lanouhn on 16/1/1.
//  Copyright © 2016年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RadiosModel : NSObject
@property (nonatomic, copy) NSString *ID, *title, *image_url;
+(id)newRadioModelWithDic:(NSDictionary *)dic;
@end
