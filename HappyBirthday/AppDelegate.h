//
//  AppDelegate.h
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 26.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TAServiceLocator;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TAServiceLocator *serviceLocator;

@end

