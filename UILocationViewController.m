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
GMSMapView *mapView_;


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
    
    
    
    //    construct the google map
    
    // make a request for local hostpitals
    //    https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522,151.1957362&rankby=distance&types=hospital&sensor=false&key=AIzaSyDdvHoGGT7Joh240-3iwVdub8Y0VMtqzQ8
    
    //    parse the response to get hospital objects
    
    // create the markers
    
    
    locationController = [[MyCLController alloc] init];
    [locationController.locationManager startUpdatingLocation];
    
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView_;
    
    //[self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.google.com/maps/preview/search/hospital"]]];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
