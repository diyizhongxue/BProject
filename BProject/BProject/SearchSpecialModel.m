//
//  SearchSpecialModel.m
//  BProject
//
//  Created by lanouhn on 15/12/28.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "SearchSpecialModel.h"

@implementation SearchSpecialModel
+(id)searchSpecialModelWithDic:(NSDictionary *)dic {
    SearchSpecialModel *specialModel = [[SearchSpecialModel alloc] init];
    
    specialModel.ID = dic[@"id"];
    specialModel.title = dic[@"title"];
    specialModel.content_num = dic[@"content_num"];
    specialModel.image_url = dic[@"image_url"];
    specialModel.play_num = dic[@"play_num"];
    
    return specialModel;
}



- (NSString *)description
{
    return [NSString stringWithFormat:@"ID:%@, title: %@, content_num:%@, image_url:%@, play_num:%@", _ID, _title, _content_num, _image_url, _play_num];
}

@end
