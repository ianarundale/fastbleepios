//
//  UILocationViewController.m
//  SingleViewApp
//
//  Created by Ian Arundale on 27/01/2014.
//  Copyright (c) 2014 Ian Arundale. All rights reserved.
//

#import "UILocationViewController.h"
#import "MyCLController.h"

@interface UILocationViewController ()

@end

@implementation UILocationViewController
@synthesize locationController;
@synthesize myWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    locationController = [[MyCLController alloc] init];
    [locationController.locationManager startUpdatingLocation];
    
    [self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.google.com/maps/preview/search/hospital"]]];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
