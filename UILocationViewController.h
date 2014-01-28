//
//  UILocationViewController.h
//  SingleViewApp
//
//  Created by Ian Arundale on 27/01/2014.
//  Copyright (c) 2014 Ian Arundale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyCLController.h"
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import "PlacesController.h"


@interface UILocationViewController : UIViewController

@property (strong, nonatomic) MyCLController *locationController;
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property double *latitude;
@property double *longitude;



@end
