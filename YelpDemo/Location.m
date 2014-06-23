//
//  Location.m
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/18/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import "Location.h"
#import "Address.h"

@implementation Location

-(id) initWithDictionary: (NSDictionary*) data{
    self = [super init];
    
    self.address = [[Address alloc] initWithSingleAddressLine:data[@"address"]];
    self.city = data[@"city"];
    self.stateCode = data[@"state_code"];
    self.countryCode = data[@"country_code"];
    self.postalCode = data[@"postal_code"];
    self.crossStreets = data[@"country_code"];
    self.neighborhoods = [NSArray arrayWithArray:data[@"neighborhoods"]];
    self.displayAddress = [[Address alloc] initWithFullAddressArray:data[@"display_address"]];
    self.coordinate = [[Center alloc] initWithDictionary:data[@"coordinate"]];
    
    return self;
}

@end
