//
//  SearchProgrameModel.h
//  BProject
//
//  Created by lanouhn on 15/12/28.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchProgrameModel : NSObject
@property (nonatomic, copy)NSNumber *ID, *album_id, *play_num, *audio_64_size;
@property (nonatomic, copy) NSString *title, *image_url, *audio_64_url, *album_title;
+(id)searchPragrameModelWithDid:(NSDictionary *)dic;

@end
