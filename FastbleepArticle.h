//
//  FastbleepArticle.h
//  SingleViewApp
//
//  Created by Ian Arundale on 26/01/2014.
//  Copyright (c) 2014 Ian Arundale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FastbleepArticle : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *status;

@end
