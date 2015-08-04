//
//  TAHoliday.m
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 03.08.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import "TAHoliday.h"

@implementation TAHoliday

- (id) initWithName:(NSString*)name date:(NSDate*)date categoryIndex:(NSInteger)categoryIndex
{
    self = [super init];
    if (self) {
        _name = name;
        _categoryIndex = categoryIndex;
        _date = date;
    }
    return self;
}

- (id) initWithName:(NSString *)name dateString:(NSString *)dateString categoryIndex:(NSInteger)categoryIndex
{
    self = [super init];
    if (self) {
        _name = name;
        _categoryIndex = categoryIndex;
        //1.1;1.4;9.12;9.11;1.4;10.10;11.12;31.12

        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"d.m"];
        _date = [dateFormatter dateFromString:dateString];
    }
    return self;
}

@end
