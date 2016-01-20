//
//  SearchSpecialModel.h
//  BProject
//
//  Created by lanouhn on 15/12/28.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchSpecialModel : NSObject
@property (nonatomic, copy) NSString *title,  *image_url; ;
@property (nonatomic, assign) NSNumber *ID, *content_num, *play_num;
+(id)searchSpecialModelWithDic:(NSDictionary *)dic;

@end
