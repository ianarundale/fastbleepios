//
//  MyCLController.m
//  SingleViewApp
//
//  Created by Ian Arundale on 27/01/2014.
//  Copyright (c) 2014 Ian Arundale. All rights reserved.
//

#import "MyCLController.h"

@implementation MyCLController

@synthesize locationManager;

- (id) init {
    self = [super init];
    if (self != nil) {
        [self startStandardUpdates];
    }
    return self;
}

- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == locationManager)
        locationManager = [[CLLocationManager alloc] init];
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    locationManager.distanceFilter = 500; // meters
    
    [locationManager startUpdatingLocation];
}


// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    
    NSLog(@"latitude %+.6f, longitude %+.6f\n",
          location.coordinate.latitude,
          location.coordinate.longitude);

}








@end
