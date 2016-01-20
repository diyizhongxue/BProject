//
//  HotRadioModel.h
//  BProject
//
//  Created by lanouhn on 15/12/31.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotRadioModel : NSObject
@property (nonatomic, copy) NSString *ID, *title, *desc, *image_url, *play_num;
@property (nonatomic, strong) NSMutableArray *tagsArr;
+(id)hotRadioModelWithDic:(NSDictionary *)dic;

@end
