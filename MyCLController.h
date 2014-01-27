//
//  MyCLController.h
//  SingleViewApp
//
//  Created by Ian Arundale on 27/01/2014.
//  Copyright (c) 2014 Ian Arundale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface MyCLController : NSObject <CLLocationManagerDelegate> {
	CLLocationManager *locationManager;
}

@property (nonatomic, retain) CLLocationManager *locationManager;

@end

