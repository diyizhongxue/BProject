//
//  AppDelegate.m
//  BProject
//
//  Created by lanouhn on 15/12/24.
//  Copyright © 2015年 贺江飞. All rights reserved.
//

#import "AppDelegate.h"
#import "MMDrawerController.h"
#import "LeftVC.h"
#import "RightTabBarViewController.h"
#import <CoreData/CoreData.h>
#import "UMSocial.h"
#import "WelcomePageView.h"
@interface AppDelegate ()
@property (nonatomic, strong) WelcomePageView *welcome;//引导页
@end

@implementation AppDelegate
//@synthesize 关联属性 和 实例变量
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel  =_managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

      //关联storyBoard对应的tabBarVC
    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //初始化左右视图
    LeftVC *leftVC = [[LeftVC alloc] init];
    
    //初始化右侧视图用Storyboard的ID
    RightTabBarViewController *RightTabBarVC = [board instantiateViewControllerWithIdentifier:@"right"];
    
    //初始化抽屉类
    MMDrawerController *mmd = [[MMDrawerController alloc] initWithCenterViewController:RightTabBarVC leftDrawerViewController:leftVC];
    mmd.maximumLeftDrawerWidth = KScreenWidth*4 /5.0;//抽屉深度
    //打开手势
    [mmd setOpenDrawerGestureModeMask:(MMOpenDrawerGestureModeAll)];
    //关闭手势
    [mmd setCloseDrawerGestureModeMask:(MMCloseDrawerGestureModeAll)];
    self.window.rootViewController = mmd;
    
//  //  //友盟分享
    [UMSocialData setAppKey:@"569dd91367e58e0fd7001863"];
    [self welcomePage];//调用开机引导页
    return YES;
}

// 开机引导页
- (void)welcomePage{
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"Run"]) {
        
        NSArray *array = @[@"op1",
                           @"op2",
                           @"op3",
                           @"op4"
                           ];
        self.welcome = [[WelcomePageView alloc] initWithFrame:self.welcome.bounds namesArray:array];
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:_welcome];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Run"];
        
        [_welcome.guideBtn addTarget:self action:@selector(beginExperience:) forControlEvents:(UIControlEventTouchUpInside)];

    }else{
    
        NSLog(@"不是第一次");

    }
    
}

//回到主页面
- (void)beginExperience:(UIButton *)button {
    [self.welcome removeFromSuperview];//移除欢迎页面
    NSLog(@"到底走没走");
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Core Data stack


//获取document文件夹路径
- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.lanou3g.LessonCoreData" in the application's documents directory.
    
    
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
//重写 getter 方法
- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    //找到 LessonCoreData.xcdatamodeld 文件
    //.xcdatamodeld编译过后叫做 momd 文件
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Bproject" withExtension:@"momd"];
    
    //根据文件路径初始化 managedObjectModel
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

//重写 getter 方法
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    //1. 根据 model 初始化助理
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    //2. 在documents路径下面添加一个 LessonCoreData.sqlite
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"LessonCoreData.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    
    //存储器类型分为: NSSQLiteStoreType
    //              NSXMLStoreType
    //              NSBinaryStoreType
    //              NSInMemoryStoreType
    //常用类型是:  NSSQLiteStoreType
    // addPersistentStoreWithType:configuration:URL:storeURL:error: 这个方法的作用是 在指定的 URL 中添加存储器
    // 如果创建失败, 走 if 内的语句
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
        //作用是终止程序, 也称crash.
        abort();
        
        //作用是终止程序, 也称crash.
        //        exif(0);
    }
    
    return _persistentStoreCoordinator;
}

//重写 managedObjectContext 的 getter 方法
- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    
    //初始化被管理对象上下文
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    //指定持久化存储助手
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

//保存上下文
- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        
        //如果上下文存在改变
        //并且保存失败
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            //终止程序
            abort();
        }
    }
}


@end
