//
//  TAFriend.m
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 26.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import "TAFriend.h"

@implementation TAFriend

- (id) initWithName:(NSString*)name vkId:(NSUInteger)vkId imgUrl:(NSURL*)url andBirthDate:(NSDate*)birthDate
{
    self = [super init];
    if (self) {
        _name = name;
        _vkId = vkId;
        _imgUrl = url;
        _birthDate = birthDate;
    }
    return self;
}

@end
