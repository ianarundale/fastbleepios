//
//  PlacesController.h
//  SingleViewApp
//
//  Created by Ian Arundale on 28/01/2014.
//  Copyright (c) 2014 Ian Arundale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlacesModel.h"

@interface PlacesController : NSObject
- (id)init;
- (NSMutableArray *)getPlaces:(NSString *)latitude withLong:(NSString *)longitude;


@end
