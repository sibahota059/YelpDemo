//
//  Span.m
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/18/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import "Span.h"

@implementation Span

-(id) initWithDictionary: (NSDictionary*) data{
    self = [super init];
    self.latitudeDelta = [data[@"latitude_delta"] doubleValue];
    self.longitudeDelta = [data[@"longitude_delta"] doubleValue];
    return self;
}


@end
