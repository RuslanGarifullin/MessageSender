//
//  TABirthday.m
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 26.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import "TABirthday.h"
#import "TASubscriber.h"

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
        if (subscribers) {
            _subscribers = [[NSMutableArray alloc] initWithArray:subscribers copyItems:YES];
        } else {
            _subscribers = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (BOOL) existSubscriberAtIndex:(NSUInteger)userId
{
    __block BOOL exist = NO;
    [self.subscribers enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[TASubscriber class]])
        {
            if ([(TASubscriber*)obj userId] == userId) {
                exist = YES;
                *stop = YES;
            }
        }
    }];
    return exist;
}

- (void) addSubscriberAtIndex:(NSUInteger)userId
{
    __block NSInteger index = -1;
    [self.subscribers enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[TASubscriber class]])
        {
            if ([(TASubscriber*)obj userId] == userId) {
                index = idx;
                *stop = YES;
            }
        }
    }];
    if (index == -1) {
        [self.subscribers addObject:[[TASubscriber alloc] initWithUserId:userId]];
    }
}

- (void) removeSubscriberAtIndex:(NSUInteger)userId
{
    __block NSInteger index = -1;
    [self.subscribers enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[TASubscriber class]])
        {
            if ([(TASubscriber*)obj userId] == userId) {
                index = idx;
                *stop = YES;
            }
        }
    }];
    if (index > -1) {
        [self.subscribers removeObjectAtIndex:index];
    }
}

- (NSString*) stringDate
{
    if (self.date) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm dd.MM.yyyy"];
        return [formatter stringFromDate:self.date];
    } else {
        return @"установить";
    }
}

@end
