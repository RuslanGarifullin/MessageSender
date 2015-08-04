//
//  TAServiceLocator.h
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 04.08.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TAApiService, TAStorageService;

@interface TAServiceLocator : NSObject

+ (instancetype) sharedServiceLocator;
@property (nonatomic, strong) TAApiService *mainApiService;
@property (nonatomic, strong) TAStorageService *mainStorageService;

@end
