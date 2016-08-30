//
//  UserInfoViewController.m
//  Reflection-Demo
//
//  Created by 刘小壮 on 16/8/30.
//  Copyright © 2016年 刘小壮. All rights reserved.
//

#import "UserInfoViewController.h"

@implementation UserInfoViewController

- (void)refreshUserInformation {
    NSLog(@"User Name : %@, User Age : %ld", self.name, [self.age integerValue]);
}

@end
