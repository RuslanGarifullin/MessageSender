//
//  TABirthday.m
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 26.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import "TABirthday.h"

@implementation TABirthday

- (id) initWithTitle:(NSString*)title{
    self = [super init];
    if (self) {
        _title = title;
    }
    return self;
}

- (id) copyWithZone:(NSZone *)zone
{
    return [[TABirthday alloc] initWithTitle:self.title message:self.message date:self.date andSubscribers: self.subscribers andEnable:self.enable];
}

- (id) initWithTitle:(NSString*)title message:(NSString*)message date:(NSDate*)date andSubscribers:(NSMutableArray*)subscribers andEnable:(BOOL)enable {
    
    self = [super init];
    if (self) {
        _title = title;
        _message = message;
        _date = date;
        _subscribers = [subscribers copy];
        _enable = enable;
    }
    return self;
}


@end
