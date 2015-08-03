//
//  TASubscriber.m
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 02.08.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import "TASubscriber.h"

@implementation TASubscriber

- (id) initWithUserId:(NSUInteger)userId
{
    self = [super init];
    if (self) {
        _userId = userId;
    }
    return self;
}

- (id) copyWithZone:(NSZone *)zone
{
    TASubscriber *subscr = [[TASubscriber alloc] initWithUserId:self.userId];
    return subscr;
}


@end
