//
//  PlacesModel.h
//  SingleViewApp
//
//  Created by Ian Arundale on 28/01/2014.
//  Copyright (c) 2014 Ian Arundale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlacesModel : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lng;
@property (strong, nonatomic) NSString *vicinity;


@end
