//
//  PlacesController.m
//  SingleViewApp
//
//  Created by Ian Arundale on 28/01/2014.
//  Copyright (c) 2014 Ian Arundale. All rights reserved.
//

#import "PlacesController.h"

@implementation PlacesController

- (id)init
{
    self = [super init];
    return self;
}

-(NSMutableArray *) getPlaces:(NSString *)latitude withLong:(NSString *)longitude
{
    
    latitude = [latitude stringByAppendingString:@","];
    latitude = [latitude stringByAppendingString:longitude];
    
    NSString *googleUrl = @"https://maps.googleapis.com/maps/api/place/nearbysearch/json?rankby=distance&types=hospital&sensor=true&key=AIzaSyDdvHoGGT7Joh240-3iwVdub8Y0VMtqzQ8&location=";
    
    googleUrl = [googleUrl stringByAppendingString:latitude];
    
    NSLog(googleUrl);
    
    NSData *placesJson = [[NSData alloc] initWithContentsOfURL:
                               [NSURL URLWithString:googleUrl]];
    
    NSError *error;
    NSMutableDictionary *placesData = [NSJSONSerialization
                                        JSONObjectWithData:placesJson
                                        options:NSJSONReadingMutableContainers
                                        error:&error];
    
    NSMutableArray *places = [[NSMutableArray alloc] init];
    
    
    if( error )
    {
        NSLog(@"%@", [error localizedDescription]);
    }
    else {
        for ( NSDictionary *place in placesData[@"results"] )
        {
            PlacesModel *item = [[PlacesModel alloc] init];
            item.name =  place[@"name"];
            item.vicinity =  place[@"vicinity"];
            item.lat =  place[@"geometry"][@"location"][@"lat"];
            item.lng =  place[@"geometry"][@"location"][@"lng"];
                        
            [places addObject:item];
        }
    }
    
    NSLog(@"Got the data for the table");
    
    return places;
}


@end
