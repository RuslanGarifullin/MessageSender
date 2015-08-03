//
//  TAApplicationStorage.h
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 28.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TABirthday, TAFriend;

@interface TAApplicationStorage : NSObject

@property (strong, nonatomic) NSMutableArray *birthdaysArray;
@property (strong, nonatomic) NSMutableArray *friendsArray;

@property (copy, nonatomic) TABirthday *changingBirthday;
@property (assign, nonatomic) NSUInteger changingIndex;

@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) NSString *userVkId;
@property (strong, nonatomic) NSString *userName;

+ (instancetype) sharedLocator;
- (void) startChangingBirthdayAtIndex:(NSUInteger)index;
- (void) accessChanging;
- (void) removeCurrentBirthday;
- (void) createNewBirthdayAndStartChanging;
- (TAFriend*) friendAtId:(NSUInteger)userId;

@end
