//
//  FastbleepAPI.h
//  SingleViewApp
//
//  Created by Ian Arundale on 26/01/2014.
//  Copyright (c) 2014 Ian Arundale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FastbleepAPI : NSObject

@property NSString *fastbleepApiUrl;

- (id)init;
- (BOOL)getArticle:(NSString *)articleId;
- (NSMutableArray *)getArticlesByCategoryId:(NSString *)articleId;
- (NSString *)stringCleaner;


@end
