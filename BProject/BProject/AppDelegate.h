//
//  AppDelegate.h
//  BProject
//
//  Created by lanouhn on 15/12/24.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic,strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;

- (NSURL *)applicationDocumentsDirectory;

@end

