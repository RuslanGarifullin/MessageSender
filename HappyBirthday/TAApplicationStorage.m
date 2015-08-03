//
//  TAApplicationStorage.m
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 28.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import "TAApplicationStorage.h"
#import "TABirthday.h"
#import "TAFriend.h"
#import "AppDelegate.h"

@interface TAApplicationStorage ()

@end

@implementation TAApplicationStorage

+ (instancetype) sharedLocator
{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    return appDelegate.storage;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.birthdaysArray = [[NSMutableArray alloc] init];
        NSDateComponents *dateComp = [NSDateComponents new];
        [dateComp setDay:7];
        [dateComp setYear:2015];
        [dateComp setMonth:5];
        
        [self.birthdaysArray addObject:[[TABirthday alloc] initWithTitle:@"8 марта"
    message:@"Дорогая (имя), поздравляю тебя с 8 марта! Желаю тебе всего самого светлого и тёплого!)"
       date:[[NSCalendar currentCalendar] dateFromComponents:dateComp] andSubscribers:nil andEnable:YES]];
        
        
        [dateComp setDay:23];
        [dateComp setYear:2015];
        [dateComp setMonth:2];
        [self.birthdaysArray addObject:[[TABirthday alloc]
                                        initWithTitle:@"23 февраля"
                                        message:@"(имя), поздравляю тебя с 23 февраля! Желаю счастья, здоровья, благополучия!" date:[[NSCalendar currentCalendar] dateFromComponents:dateComp] andSubscribers:nil andEnable:YES]];
        
        [dateComp setDay:19];
        [dateComp setYear:2015];
        [dateComp setMonth:12];
        [self.birthdaysArray addObject:[[TABirthday alloc] initWithTitle:@"День рождения мамы" message:@"Дорогая мама, поздравляю тебя с твоим Днём Рождением! Желаю всего самого светлого и тёплого! Твой любящий сын)" date:[[NSCalendar currentCalendar] dateFromComponents:dateComp] andSubscribers:nil andEnable:YES]];
        
        [dateComp setDay:31];
        [dateComp setYear:2015];
        [dateComp setMonth:12];
        [self.birthdaysArray addObject:[[TABirthday alloc] initWithTitle:@"Новый год" message:@"(имя), пусть новый год принесёт тебе массу впечатлейний и подарков! С Новым Годом)" date:[[NSCalendar currentCalendar] dateFromComponents:dateComp] andSubscribers:nil andEnable:YES]];
        self.friendsArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) createNewBirthdayAndStartChanging
{
    self.changingBirthday = [[TABirthday alloc] initWithTitle:@"" message:@"" date:nil andSubscribers:nil andEnable:NO];
    self.changingIndex = self.birthdaysArray.count;
}

- (void) startChangingBirthdayAtIndex:(NSUInteger)index
{
    self.changingIndex = index;
    self.changingBirthday = [self.birthdaysArray objectAtIndex:index];
}

- (void) accessChanging
{
    if (self.changingBirthday) {
        if (self.changingIndex < self.birthdaysArray.count) {
            [self.birthdaysArray replaceObjectAtIndex:self.changingIndex withObject:self.changingBirthday];
            self.changingBirthday = nil;
        } else {
            [self.birthdaysArray addObject:self.changingBirthday];
            self.changingBirthday = nil;
        }
    }
}

- (TAFriend*) friendAtId:(NSUInteger)userId
{
    __block TAFriend *friend = nil;
    [self.friendsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([(TAFriend*)obj vkId] == userId) {
            friend = obj;
            *stop = YES;
        }
    }];
    return friend;
}

- (void) removeCurrentBirthday
{
    if (self.changingIndex < self.birthdaysArray.count) {
        [self.birthdaysArray removeObjectAtIndex:self.changingIndex];
    }
    self.changingBirthday = nil;
}

@end
