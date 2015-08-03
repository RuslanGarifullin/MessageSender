//
//  TAFriend.h
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 26.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TAFriend : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSUInteger vkId;
@property (nonatomic, strong) NSURL *imgUrl;
@property (nonatomic, strong) NSDate *birthDate;

- (id) initWithName:(NSString*)name vkId:(NSUInteger)vkId imgUrl:(NSURL*)url andBirthDate:(NSDate*)birthDate;

@end
