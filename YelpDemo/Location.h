//
//  Location.h
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/18/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Address.h"
#import "Center.h"

@interface Location : NSObject

@property Address *address;
@property NSString *city;
@property Address *displayAddress;
@property NSString *stateCode;
@property NSString *postalCode;
@property NSString *countryCode;
@property NSString *crossStreets;
@property NSArray *neighborhoods;
@property Center *coordinate;

-(id) initWithDictionary: (NSDictionary*) data;

@end
