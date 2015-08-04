//
//  TAApiRequestExecutor.h
//  HappyBirthday
//
//  Created by Арман Тагбергенев on 04.08.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TAApiRequestExecutor : NSObject

- (id) initExecutorWithRequest:(NSURLRequest*)request
                 dateConverter:(NSArray*(^)(NSData*))converterBlock;
- (void) startRequest;
- (void) cancelRequest;
@property (nonatomic, strong, readonly) NSURLRequest* request;
@property (nonatomic, copy, readonly) NSArray* (^converter)(NSData*);
@property (nonatomic, copy) void* (^callback)(BOOL success);

@end
