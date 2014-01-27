//
//  UIArticleViewController.m
//  SingleViewApp
//
//  Created by Ian Arundale on 26/01/2014.
//  Copyright (c) 2014 Ian Arundale. All rights reserved.
//


#import "UIArticleViewController.h"
#import "FastbleepAPI.h"

@interface UIArticleViewController ()

@end

@implementation UIArticleViewController
@synthesize myWebView;
@synthesize mylabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)favoritePressed:(id)sender {
    NSLog(@"About to add article into the favorite list");
    FastbleepDatabaseController *databaseController = [FastbleepDatabaseController new];
    [databaseController insertWithItem:self.article];
    NSLog(@"Added");
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Favorite Added" message:@"This article has been saved to your favorites" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alertView.alertViewStyle = UIAlertViewStyleDefault;
    [alertView show];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *baseUrl = @"http://stage.fastbleep.com/api/revisionnotes/getarticle/";
    //baseUrl = @"http://www.fastbleep.com/medical-notes/heart-lungs-blood/1/1/";
    NSString *articleIdToGet = self.articleId;
    baseUrl = [baseUrl stringByAppendingString:articleIdToGet];
    
    //
    FastbleepAPI *fastbleepAPI = [[FastbleepAPI alloc] init];
    
    // set the url
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:baseUrl]]];
    
    NSString *embedHTML = @"<html><head><style> body { font-family: \"Helvetica Neue\",Helvetica,Arial,sans-serif; font-size: 16px;} a { color: black; text-decoration: none; } img{ max-width: 100% } </style></head>";
    embedHTML = [embedHTML stringByAppendingString:self.article.content];
    [self.myWebView loadHTMLString: embedHTML baseURL: nil];
    self.mylabel.text = self.article.title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
