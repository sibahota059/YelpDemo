//
//  Center.m
//  YelpDemo
//
//  Created by Abhijeet Vaidya on 6/18/14.
//  Copyright (c) 2014 yahoo inc. All rights reserved.
//

#import "Center.h"

@implementation Center

-(id) initWithDictionary: (NSDictionary*) data{
    self = [super init];
    self.latitude = [data[@"latitude"] doubleValue];
    self.longitude = [data[@"longitude"] doubleValue];
    return self;
}

@end
