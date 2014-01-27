//
//  FastbleepDatabaseController.h
//  SingleViewApp
//
//  Created by Ian Arundale on 27/01/2014.
//  Copyright (c) 2014 Ian Arundale. All rights reserved.
//

#import <sqlite3.h>
#import <Foundation/Foundation.h>
#import "FastbleepArticle.h"

@interface FastbleepDatabaseController : NSObject

- (BOOL)createDatabase;
- (BOOL)insertWithItem:(FastbleepArticle *)item;
- (NSArray *)select;

@end
