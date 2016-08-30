//
//  UserInfoViewController.h
//  Reflection-Demo
//
//  Created by 刘小壮 on 16/8/30.
//  Copyright © 2016年 刘小壮. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoViewController : UIViewController
/** 用户名 */
@property (nonatomic,strong) NSString *name;
/** 用户年龄 */
@property (nonatomic,strong) NSNumber *age;

/**
 *  使用反射机制反射为SEL后，调用的方法
 */
- (void)refreshUserInformation;
@end
