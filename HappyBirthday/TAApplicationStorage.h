//
//  TAApplicationStorage.h
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 28.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TAApplicationStorage : NSObject

+ (instancetype) sharedLocator;
@property (strong, nonatomic) NSMutableArray *birthdaysArray;
@property (strong, nonatomic) NSMutableArray *friendsArray;

@end
