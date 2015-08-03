//
//  TABirthday.h
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 26.07.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TABirthday : NSObject <NSCopying>

@property (nonatomic, strong) NSMutableArray *subscribers;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) BOOL enable;


- (id) initWithTitle:(NSString*)title message:(NSString*)message date:(NSDate*)date andSubscribers:(NSMutableArray*)subscribers andEnable:(BOOL)enable;
- (id) initWithTitle:(NSString*)title;
- (NSString*) stringDate;
- (BOOL) existSubscriberAtIndex:(NSUInteger)userId;
- (void) addSubscriberAtIndex:(NSUInteger)userId;
- (void) removeSubscriberAtIndex:(NSUInteger)userId;

@end
