//
//  AppDelegate.m
//  Reflection-Demo
//
//  Created by 刘小壮 on 16/8/30.
//  Copyright © 2016年 刘小壮. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@implementation AppDelegate

#pragma mark - ----- Life Cycle ------

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.naviController            = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.window.rootViewController = self.naviController;
    [self.window makeKeyAndVisible];
    
    // 模拟远程调用，延迟十秒
    [self testRemoteNotification];
    
    return YES;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    [self remoteNotificationDictionary:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

// 简单封装的页面跳转方法，只是做演示，代码都是没问题的，使用时可以根据业务需求进行修改。
- (void)remoteNotificationDictionary:(NSDictionary *)dict {
    // 根据字典字段反射出我们想要的类，并初始化控制器
    Class class = NSClassFromString(dict[@"className"]);
    UIViewController *vc = [[class alloc] init];
    // 获取参数列表，使用枚举的方式，对控制器属性进行KVC赋值
    NSDictionary *parameter = dict[@"propertys"];
    [parameter enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        // 在属性赋值时，做容错处理，防止因为后台数据导致的异常
        if ([vc respondsToSelector:NSSelectorFromString(key)]) {
            [vc setValue:obj forKey:key];
        }
    }];
    [self.naviController pushViewController:vc animated:YES];
    // 从字典中获取方法名，并调用对应的方法
    SEL selector = NSSelectorFromString(dict[@"method"]);
    // 如果想消除黄色警告，可以通过clang编译指令消除
    [vc performSelector:selector];
}

- (void)testRemoteNotification {
    // 模拟远程通知的调用
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSDictionary *dict = @{
                               // 类名
                               @"className" : @"UserInfoViewController",
                               // 数据参数
                               @"propertys" : @{@"name": @"liuxiaozhuang",
                                                @"age": @3},
                               // 调用方法名
                               @"method" : @"refreshUserInformation"};
        
        [self application:[UIApplication sharedApplication] didReceiveRemoteNotification:dict fetchCompletionHandler:^(UIBackgroundFetchResult result) {
            
        }];
    });
}

#pragma mark - ----- Setter && Getter ------

- (ViewController *)viewController {
    if (!_viewController) {
        _viewController = [[ViewController alloc] init];
    }
    return _viewController;
}

- (UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
    return _window;
}

@end

















