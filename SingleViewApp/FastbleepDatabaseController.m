//
//  FastbleepDatabaseController.m
//  SingleViewApp
//
//  Created by Ian Arundale on 27/01/2014.
//  Copyright (c) 2014 Ian Arundale. All rights reserved.
//


#import "FastbleepDatabaseController.h"


@implementation FastbleepDatabaseController

NSString *databasePath;
sqlite3 *database = nil;
sqlite3_stmt *statement = nil;

- (id)init
{
    if(self=[super init])
    {
        NSArray *directorySearchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
        NSString *documentDirectory = (NSString *)[directorySearchPaths objectAtIndex:0];
        databasePath = [[NSString alloc] initWithString:[documentDirectory stringByAppendingPathComponent:@"FASTBLEEP.database"]];
        [self createDatabase];
    }
    return self;
}

- (BOOL)createDatabase
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:databasePath])
    {
        const char *databasePathUTF8 = [databasePath UTF8String];
        if(sqlite3_open(databasePathUTF8,&database)==SQLITE_OK)
        {
            char *error;
            const char *createQuery = "CREATE TABLE IF NOT EXISTS FASTBLEEP (ID INTEGER PRIMARY KEY AUTOINCREMENT, FASTBLEEPID INTEGER, TITLE TEXT, CONTENT TEXT, STATUS TEXT)";
            if(sqlite3_exec(database,createQuery,NULL,NULL,&error)!=SQLITE_OK)
            {
                return NO;
            }
            else
            {
                return YES;
            }
            sqlite3_close(database);
        }
        else
        {
            return NO;
        }
    }
    return YES;
}


- (BOOL)insertWithItem:(FastbleepArticle *)item
{
    
    // Should be checking if the item already exists in the datasource to ensure we dont store the same thing twice
    
    const char *databasePathUTF8 = [databasePath UTF8String];
    if(sqlite3_open(databasePathUTF8,&database)==SQLITE_OK)
    {
        NSString *insertQuery = [NSString stringWithFormat:@"INSERT INTO FASTBLEEP (FASTBLEEPID, TITLE, CONTENT, STATUS) VALUES (\"%@\",\"%@\",\"%@\",\"%@\")",
                                 [item.id stringByReplacingOccurrencesOfString:@"\"" withString:@"''"],
                                 [item.title stringByReplacingOccurrencesOfString:@"\"" withString:@"''"],
                                 [item.content stringByReplacingOccurrencesOfString:@"\"" withString:@"''"],
                                 [item.status stringByReplacingOccurrencesOfString:@"\"" withString:@"''"]];
        const char *insertQueryUTF8 = [insertQuery UTF8String];
        sqlite3_prepare_v2(database,insertQueryUTF8,-1,&statement,NULL);
        if(sqlite3_step(statement)==SQLITE_DONE)
        {
            return YES;
        }
        else
        {
            return NO;
        }
        sqlite3_reset(statement);
    }
    else
    {
        return NO;
    }
    return YES;
}


- (NSArray *)select
{
    const char *databasePathUTF8 = [databasePath UTF8String];
    if(sqlite3_open(databasePathUTF8,&database)==SQLITE_OK)
    {
        NSString *selectQuery = [NSString stringWithFormat:@"SELECT FASTBLEEPID, TITLE, CONTENT, STATUS FROM FASTBLEEP ORDER BY ID ASC"];
        const char *selectQueryUTF8 = [selectQuery UTF8String];
        if(sqlite3_prepare_v2(database,selectQueryUTF8,-1,&statement,NULL)==SQLITE_OK)
        {
            NSMutableArray *mutableArray = [NSMutableArray new];
            while(sqlite3_step(statement)==SQLITE_ROW)
            {
                FastbleepArticle *article = [FastbleepArticle new];
                article.id = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement,0)];
                article.title = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement,1)];
                article.content = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement,2)];
                article.status = [[NSString alloc] initWithUTF8String:(const char *)sqlite3_column_text(statement,3)];

                [mutableArray addObject:article];
            }
            sqlite3_close(database);
            
            return [NSArray arrayWithArray:mutableArray];
        }
        else
        {
            return nil;
        }
    }
    else
    {
        return nil;
    }
}





@end
