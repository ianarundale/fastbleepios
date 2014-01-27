//
//  UIFastbleepMenuTableViewController.m
//  SingleViewApp
//
//  Created by Ian Arundale on 26/01/2014.
//  Copyright (c) 2014 Ian Arundale. All rights reserved.
//

#import "UIFastbleepMenuTableViewController.h"
#import "UIArticleViewController.h"
#import "FastbleepAPI.h"
#import "FastbleepArticle.h"

@interface UIFastbleepMenuTableViewController ()

@end

@implementation UIFastbleepMenuTableViewController
@synthesize articles = _articles;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        FastbleepAPI *fbApi = [[FastbleepAPI alloc] init];
        self.articles = [fbApi getArticlesByCategoryId: @"1"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    FastbleepAPI *fbApi = [[FastbleepAPI alloc] init];
    self.articles = [fbApi getArticlesByCategoryId: @"1"];
    
    [self.tableView reloadData];
    
    NSLog(@"Reloaded data");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"Memory warning Error");
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"segue prepare");
    if([segue.identifier isEqualToString:@"ViewFastbleepArticleSegue"]){
        // pass the article to the new view controller
        UIArticleViewController *articleViewController = segue.destinationViewController;
        FastbleepArticle *chosenArticle = [self.articles objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        articleViewController.articleId = chosenArticle.id;
        articleViewController.article = chosenArticle;
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"returning the number of sections");
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"returning the number of rows ");
    NSUInteger *count = [self.articles count];
    //return 1;
    return self.articles.count;
}


- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"FastbleepCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //NSString *currentArticle = [self.articles objectAtIndex:indexPath.row];
    FastbleepArticle *currentArticle = [self.articles objectAtIndex:indexPath.row];
    
    cell.textLabel.text = currentArticle.title;
    
    NSLog(@"Getting cell ");
    
    return cell;
}
 


@end
