//
//  TAApiRequestExecutor.m
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 04.08.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import "TAApiRequestExecutor.h"

@implementation TAApiRequestExecutor

- (id) initExecutorWithRequest:(NSURLRequest*)request dateConverter:(NSArray*(^)(NSData*))converterBlock
{
    if ((self = [super init])) {
        _request = request;
        _converter = converterBlock;
    }
    return self;
}

- (void) startRequest
{
    
}

- (void) cancelRequest
{
    
}


@end
