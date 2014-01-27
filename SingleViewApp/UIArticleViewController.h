//
//  UIArticleViewController.h
//  SingleViewApp
//
//  Created by Ian Arundale on 26/01/2014.
//  Copyright (c) 2014 Ian Arundale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FastbleepArticle.h"
#import "FastbleepDatabaseController.h"

@interface UIArticleViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@property (weak, nonatomic) IBOutlet UILabel *mylabel;

@property (strong, nonatomic) NSString *articleId;
@property (strong, nonatomic) FastbleepArticle *article;


@end
