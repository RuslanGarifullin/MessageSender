//
//  TAApplicationStorage.m
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 28.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import "TAStorageService.h"
#import "TABirthday.h"
#import "TAFriend.h"
#import "AppDelegate.h"
#import "DataBaseService.h"


@implementation TAStorageService

- (instancetype)init
{
    self = [super init];
    if (self) {
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
