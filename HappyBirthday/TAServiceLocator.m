//
//  TAServiceLocator.m
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 04.08.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import "TAServiceLocator.h"
#import "TAStorageService.h"
#import "TAApiService.h"
#import "AppDelegate.h"

@implementation TAServiceLocator

+ (instancetype) sharedServiceLocator
{
     AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    return appDelegate.serviceLocator;
}

- (id) init
{
    if ((self = [super init])) {
        _mainApiService = [[TAApiService alloc] init];
        _mainStorageService = [[TAStorageService alloc] init];
    }
    return self;
}

@end
