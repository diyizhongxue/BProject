//
//  HistoryModel+CoreDataProperties.h
//  
//
//  Created by lanouhn on 16/1/13.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "HistoryModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HistoryModel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *des;
@property (nullable, nonatomic, retain) NSString *image_url;
@property (nullable, nonatomic, retain) NSString *myID;
@property (nullable, nonatomic, retain) NSString *name;

@end

NS_ASSUME_NONNULL_END
