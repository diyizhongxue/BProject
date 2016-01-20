//
//  SearchProgrameModel.m
//  BProject
//
//  Created by lanouhn on 15/12/28.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "SearchProgrameModel.h"

@implementation SearchProgrameModel

+(id)searchPragrameModelWithDid:(NSDictionary *)dic{
    SearchProgrameModel *programeModel = [[SearchProgrameModel alloc] init];
    
    [programeModel setValuesForKeysWithDictionary:dic];
     programeModel.play_num = dic[@"play_num"];
    return programeModel;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

@end
