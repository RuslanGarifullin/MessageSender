//
//  DataBaseService.m
//  HappyBirthday
//
//  Created by Ruslan on 04.08.15.
//  Copyright (c) 2015 Tagbergenev Arman. All rights reserved.
//

#import "DataBaseService.h"


@implementation DataBaseService

- (FMDatabase *) dataBase
{
    if (!_dataBase) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docsPath = [paths objectAtIndex:0];
        NSString *path = [docsPath stringByAppendingPathComponent:@"database.sqlite"];
        _dataBase = [FMDatabase databaseWithPath:path];
    }
    return _dataBase;
}

- (void) inizializationTable
{
    [self.dataBase open];
    [self.dataBase executeUpdate:@"create table myPattern(id int primary key,pattern text)"];
    [self.dataBase executeUpdate:@"create table customPattern(id int primary key,pattern text)"];
    [self.dataBase executeUpdate:@"create table Message(id int primary key,massege text)"];
    [self.dataBase]
    
    
    

}





@end
