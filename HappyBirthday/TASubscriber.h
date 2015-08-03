//
//  TASubscriber.h
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 02.08.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TASubscriber : NSObject <NSCopying>

@property (nonatomic, assign) NSUInteger userId;
@property (nonatomic, strong) NSString *overridedMessage;

- (id) initWithUserId:(NSUInteger)userId;

@end
