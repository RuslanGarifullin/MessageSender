//
//  TAHoliday.h
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 03.08.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TAHoliday : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSUInteger categoryIndex;
- (id) initWithName:(NSString*)name date:(NSDate*)date categoryIndex:(NSInteger)categoryIndex;
- (id) initWithName:(NSString*)name dateString:(NSString*)dateString categoryIndex:(NSInteger)categoryIndex;

@end
