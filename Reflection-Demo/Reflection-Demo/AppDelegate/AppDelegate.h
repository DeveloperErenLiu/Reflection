//
//  AppDelegate.h
//  Reflection-Demo
//
//  Created by 刘小壮 on 16/8/30.
//  Copyright © 2016年 刘小壮. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow               *window;
@property (nonatomic, strong) ViewController         *viewController;
@property (nonatomic, strong) UINavigationController *naviController;
@end

