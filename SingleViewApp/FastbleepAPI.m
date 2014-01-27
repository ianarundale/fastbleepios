//
//  FastbleepAPI.m
//  SingleViewApp
//
//  Created by Ian Arundale on 26/01/2014.
//  Copyright (c) 2014 Ian Arundale. All rights reserved.
//

#import "FastbleepAPI.h"
#import "FastbleepArticle.h"

@implementation FastbleepAPI

- (id)init
{
    self = [super init];
    return self;
}

-(NSMutableArray *) getArticlesByCategoryId:(NSString *)categoryId
{
    NSString *cardiologyUrl = @"http://stage.fastbleep.com/api/revisionnotes/getArticles/38";
    
    NSData *articleDataJson = [[NSData alloc] initWithContentsOfURL:
                               [NSURL URLWithString:cardiologyUrl]];
    
    NSError *error;
    NSMutableDictionary *articleData = [NSJSONSerialization
                                        JSONObjectWithData:articleDataJson
                                        options:NSJSONReadingMutableContainers
                                        error:&error];
    
    NSMutableArray *articles = [[NSMutableArray alloc] init];

    
    if( error )
    {
        NSLog(@"%@", [error localizedDescription]);
    }
    else {
        NSLog(@"Talkback: ", articleData[@"talkback"]);
        
        NSArray *talkback = articleData[@"talkback"];
        for ( NSDictionary *articleData in talkback )
        {
            FastbleepArticle *item = [[FastbleepArticle alloc] init];
            item.id =  articleData[@"id"];
            item.title =  articleData[@"title"];
            item.content =  articleData[@"content"];
            item.status =  articleData[@"status"];
            
            //[item.content stringByReplacingOccurrencesOfString:@"assets"
              //                                           withString:@"fsdafsafsad"];
           

            //item.content = [self  stringCleaner: item.content @"assets" @"BLAHBLAH"];
            
            item.content = [item.content stringByReplacingOccurrencesOfString:@"/assets/" withString:@"http://www.fastbleep.com/assets/"];


            
            
            [articles addObject:item];
            /*NSLog(@"----");
            NSLog(@"Title: %@", articleData[@"title"] );
            NSLog(@"Speaker: %@", articleData[@"id"] );
            NSLog(@"Room: %@", articleData[@"content"] );
            NSLog(@"Details: %@", articleData[@"status"] );
            NSLog(@"----");
             */
        }
    }
    
    NSLog(@"Got the data for the table");
    
    return articles;
}

- (NSString *)stringCleaner:(NSString *)yourString {
    NSScanner *theScanner;
    NSString *text = nil;
    
    theScanner = [NSScanner scannerWithString:yourString];
    
    while ([theScanner isAtEnd] == NO) {
        [theScanner scanUpToString:@"[" intoString:NULL] ;
        [theScanner scanUpToString:@"]" intoString:&text] ;
        yourString = [yourString stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@]", text] withString:@""];
    }
    
    return yourString;
}




- (BOOL) getArticle:(NSString *)articleId
{

    
    NSString *urlToCall = self.fastbleepApiUrl;
    
    NSString *baseUrl = @"http://stage.fastbleep.com/api/revisionnotes/getarticle/";
    urlToCall = baseUrl;
    urlToCall = [urlToCall stringByAppendingString: articleId];
    
    
    NSData *articleDataJson = [[NSData alloc] initWithContentsOfURL:
                              [NSURL URLWithString:urlToCall]];
    
    NSError *error;
    NSMutableDictionary *articleData = [NSJSONSerialization
                                       JSONObjectWithData:articleDataJson
                                       options:NSJSONReadingMutableContainers
                                       error:&error];
    
    if( error )
    {
        NSLog(@"%@", [error localizedDescription]);
    }
    else {
        NSLog(@"Talkback: ", articleData[@"talkback"]);
        
        NSArray *talkback = articleData[@"talkback"];
        for ( NSDictionary *articleData in talkback )
        {
            NSLog(@"----");
            NSLog(@"Title: %@", articleData[@"title"] );
            NSLog(@"Speaker: %@", articleData[@"id"] );
            NSLog(@"Room: %@", articleData[@"content"] );
            NSLog(@"Details: %@", articleData[@"status"] );
            NSLog(@"----");
        }
    }
    
    return YES;
}



-(void)update:(NSString *)currentTime
{
        
}

@end
