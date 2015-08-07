//
//  DataBaseService.h
//  HappyBirthday
//
//  Created by Ruslan on 04.08.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>

@interface DataBaseService : NSObject
@property (strong,nonatomic) FMDatabase *dataBase;
@end
