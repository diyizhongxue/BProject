//
//  SearchAfterArrModel.h
//  BProject
//
//  Created by lanouhn on 15/12/27.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchAfterArrModel : NSObject
@property (nonatomic, copy) NSString *ID, *title;
+(id)searchAfterArrModel:(NSDictionary *)dic;
@end
