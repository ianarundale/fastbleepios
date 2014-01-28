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
CLLocationManager *locationManager;


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
    
    
    //locationController = [[MyCLController alloc] init];
    //[locationController.locationManager startUpdatingLocation];
    
    
    
    
    
    
    // Create a GMSCameraPosition that tells the map to display the
    // coordinate -33.86,151.20 at zoom level 6.
    /*GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
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
    marker.map = mapView_;*/
    
    //[self.myWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.google.com/maps/preview/search/hospital"]]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self startStandardUpdates];
}

- (void)startStandardUpdates
{
    locationManager = [CLLocationManager new];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 1; // meters
    [locationManager startUpdatingLocation];
    NSLog(@"stating standard updates");
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    NSTimeInterval timeInterval = location.timestamp.timeIntervalSinceNow;
    if(abs(timeInterval)>10)
    {
        [self startStandardUpdates];
    }
    [locationManager stopUpdatingLocation];
    NSLog(@"Location: %@",location);
    
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:location.coordinate.latitude
     longitude:location.coordinate.longitude
     zoom:12];
     mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
     mapView_.myLocationEnabled = YES;
     self.view = mapView_;
    
    
    PlacesController *placesController = [[PlacesController alloc] init];
    
    NSString *latitudeString = [[NSString alloc] initWithFormat:@"%g", location.coordinate.latitude];
    NSString *longitudeString = [[NSString alloc] initWithFormat:@"%g", location.coordinate.longitude];

    
    NSMutableArray *places = [placesController getPlaces: latitudeString withLong: longitudeString];
     
     // Creates a marker in the center of the map.
    
    for ( PlacesModel *place in places ) {
        GMSMarker *marker = [[GMSMarker alloc] init];
        
        NSLog(@"creating object for ");
        NSLog(place.name);


        
        marker.position = CLLocationCoordinate2DMake([place.lat doubleValue], [place.lng doubleValue]);
        marker.title = place.name;
        marker.snippet =  place.vicinity;
        marker.map = mapView_;
    }
    
    
    
    
    //make the network request to get the google places
     
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    UIAlertView *uiAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [uiAlertView show];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
